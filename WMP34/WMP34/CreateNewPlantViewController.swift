//
//  CreateNewPlantViewController.swift
//  WMP34
// swiftlint:disable all
//  Created by Kelson Hartle on 6/24/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit

class CreateNewPlantViewController: UIViewController {
    
    @IBOutlet weak var plantname: UITextField!
    @IBOutlet weak var species: UITextField!
    @IBOutlet weak var frequency: UITextField!
    
    
    let plantController = PlantController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let plantName = plantname.text else { return }
        guard let scientificName = species.text else { return }
        guard let frequencyH20 = frequency.text else { return }
        
        let plant = Plant(nickname: plantName, species: scientificName, image: "", h2ofrequency: frequencyH20)
        
        plantController.sendPlantToServer(plant: plant)
        
        do {
            try CoreDataStack.shared.mainContext.save()
            self.dismiss(animated: true, completion: nil)
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
        
        
    }
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
