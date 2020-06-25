//
//  TestingViewController.swift
//  WMP34
//
//  Created by Bradley Diroff on 6/22/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//
import UIKit
import CoreData

class TestingViewController: UIViewController {
    
    var necessaryPresentLoginViewController: Bool {
        //TODO: Update to present login VC
        guard let _ = userController.token else { return false }
        
        return true
    }
    
    private var blockOperations: [BlockOperation] = []
    
    lazy var fetchedResultsController: NSFetchedResultsController<Plant> = {
        let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nickname", ascending: true)]
        let context = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        try! frc.performFetch()
        return frc
    }()
    
    let userController = UserController()
    let plantController = PlantController()
    
    var collectionView: UICollectionView?
    
    let dangerCell = UICollectionViewCell()
    
    var logoutBarButtonItem: UIBarButtonItem?
    var addBarButtonItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.systemGreen
        
        bringInCollectionView()
        bringInNavigationItems()
        
        dangerCell.backgroundColor = UIColor.red
        
        collectionView?.reloadData()
        
        if !necessaryPresentLoginViewController {
            presentRegisterView()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }
    
    @objc func signOutButtonTapped() {
        self.clearData()
        self.presentRegisterView()
        userController.token = nil
    }
    
    func clearData() {
        let context = CoreDataStack.shared.mainContext
        
        do {
            let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
            let allPlants = try context.fetch(fetchRequest)
            for plant in allPlants {
                let plantData: NSManagedObject = plant as NSManagedObject
                context.delete(plantData)
            }
            try context.save()
        } catch {
            NSLog("Could not fetch plants.")
        }
    }
    
    private func presentRegisterView() {
        let loginAndRegisterStoryBoard = UIStoryboard(name: "Login-Register", bundle: Bundle(identifier: "CasanovaStudios.WMP34"))
        let registerViewController = loginAndRegisterStoryBoard.instantiateViewController(withIdentifier: "Register")
        registerViewController.modalPresentationStyle = .fullScreen
        present(registerViewController, animated: true)
    }
    
    func bringInNavigationItems() {
        
     //   self.navigationController?.delegate = self
        
        logoutBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(signOutButtonTapped))
        logoutBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem  = logoutBarButtonItem!
        
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlant))
        addBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem  = addBarButtonItem!
        
    }
    
    @objc func addPlant() {
        performSegue(withIdentifier: "AddNewPlant", sender: nil)
    }
    
    @objc func logoutUser() {
        
    }
    
    func bringInCollectionView() {
        print("about to check a collectionview")
        if collectionView == nil {
            print("collectionview was nil")
            makeCollectionView()
            collectionView?.dataSource = self
            collectionView?.delegate = self
        }
    }
    
    func makeCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let cellWidth = view.frame.width - 30
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        let sized = CGRect(x: 0.0, y: 0, width: Double(self.view.frame.maxX), height: Double(self.view.frame.height))
        
        collectionView = UICollectionView(frame: sized, collectionViewLayout: layout)
        collectionView?.register(MyPlantCollectionViewCell.self, forCellWithReuseIdentifier: "MyPlantCell")
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.allowsSelection = true
        self.view.addSubview(collectionView!)
        collectionView?.reloadData()
    }
    
}

extension TestingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPlantCell", for: indexPath) as? MyPlantCollectionViewCell else { return dangerCell}
        
        let plant = fetchedResultsController.object(at: indexPath)
        cell.plant = plant
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let plant = fetchedResultsController.object(at: indexPath)
        
        performSegue(withIdentifier: "PlantDetail", sender: plant)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= -104 {
        //    print("its not 0: \(scrollView.contentOffset.y)")
            logoutBarButtonItem?.tintColor = UIColor.systemGreen
            addBarButtonItem?.tintColor = UIColor.systemGreen
        } else {
      //      print("its 0")
            logoutBarButtonItem?.tintColor = UIColor.white
            addBarButtonItem?.tintColor = UIColor.white
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddNewPlant" {
            guard let createPlantVC = segue.destination as? AddPlantViewController else { return }
            
            createPlantVC.plantController = plantController
            
            
        } else if segue.identifier == "PlantDetail" {
            guard let detailVC = segue.destination as? AddPlantViewController,
                let plant = sender as? Plant else { return }
            
            detailVC.plant = plant
            detailVC.plantController = plantController
            
        }
    }
    
}

extension TestingViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        blockOperations.removeAll(keepingCapacity: false)
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {

        var op = BlockOperation()
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            op = BlockOperation { self.collectionView?.insertItems(at: [newIndexPath]) }

        case .delete:
            guard let indexPath = indexPath else { return }
            op = BlockOperation { self.collectionView?.deleteItems(at: [indexPath]) }
        case .move:
            guard let indexPath = indexPath,  let newIndexPath = newIndexPath else { return }
            op = BlockOperation { self.collectionView?.moveItem(at: indexPath, to: newIndexPath) }
        case .update:
            guard let indexPath = indexPath else { return }
            op = BlockOperation { self.collectionView?.reloadItems(at: [indexPath]) }
        @unknown default:
            break
        }

        blockOperations.append(op)
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.performBatchUpdates({
            self.blockOperations.forEach { $0.start() }
        }, completion: { finished in
            self.blockOperations.removeAll(keepingCapacity: false)
        })
    }
}

extension TestingViewController: PlantCellDelegate {
    func timerDidFire(plant: Plant) {
        print("it made it to the timer")
        showAlert(title: "Water is required", message: "\(plant.nickname ?? "egg") needs water badly")
    }

    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
