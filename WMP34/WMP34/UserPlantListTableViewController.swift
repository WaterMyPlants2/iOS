//
//  UserPlantListTableViewController.swift
//  WMP34
//
//  Created by Kelson Hartle on 6/23/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit
import CoreData

class UserPlantListTableViewController: UITableViewController {
    var necessaryPresentLoginViewController: Bool {
        // swiftlint:disable all
        guard let _ = userController.token else { return false }
        // swiftlint:enable all
        return true
    }
    let userController = UserController()
    let plantController = PlantController()
    lazy var fetchedResultsController: NSFetchedResultsController<Plant> = {
        let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nickname", ascending: true)]
        let context = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: context,
                                             sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        // swiftlint:disable all
        try! frc.performFetch()
        // swiftlint:enable all
        return frc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        if !necessaryPresentLoginViewController {
            presentRegisterView()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    @IBAction func signOutButtonTapped(_ sender: Any) {
        self.presentRegisterView()
        userController.token = nil
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultsController.sections?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // warning Incomplete implementation, return the number of rows
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserPlantCell",
                                                       for: indexPath) as? UserPlantTableViewCell else { fatalError() }
        cell.plant = fetchedResultsController.object(at: indexPath)
        cell.delegate = self
        return cell
    }
    // MARK: - Navigation
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let plant = fetchedResultsController.object(at: indexPath)
            plantController.deletePlantFromServer(plant: plant) { result in
                // swiftlint:disable all
                guard let _ = try? result.get() else {
                    // swiftlint:enable all
                    return
                }
                DispatchQueue.main.async {
                    CoreDataStack.shared.mainContext.delete(plant)
                    do {
                        try CoreDataStack.shared.mainContext.save()
                    } catch {
                        CoreDataStack.shared.mainContext.reset()
                        NSLog("Error saving managed object context: \(error)")
                    }
                }
            }
        }
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddNewPlant" {
            guard let createPlantVC = segue.destination as? PlantDetailViewController else { return }
            createPlantVC.plantController = plantController
        } else if segue.identifier == "PlantDetail" {
            guard let detailVC = segue.destination as? PlantDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.plant = fetchedResultsController.object(at: indexPath)
            detailVC.plantController = plantController
        }
    }
    private func presentRegisterView() {
        let loginAndRegisterStoryBoard = UIStoryboard(name: "Login-Register",
                                                      bundle: Bundle(identifier: "CasanovaStudios.WMP34"))
        let registerViewController = loginAndRegisterStoryBoard.instantiateViewController(withIdentifier: "Register")
        registerViewController.modalPresentationStyle = .fullScreen
        present(registerViewController, animated: true)
    }
}

extension UserPlantListTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        @unknown default:
            break
        }
    }
}

extension UserPlantListTableViewController: PlantCellDelegate {
    func timerDidFire(plant: Plant) {
        print("it made it to the timer")
        showAlert(title: "Water is required", message: "\(plant.nickname ?? "egg") needs water badly")
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
