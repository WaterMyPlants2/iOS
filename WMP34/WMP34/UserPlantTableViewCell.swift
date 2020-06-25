//
//  UserPlantTableViewCell.swift
//  WMP34
//
//  Created by Kelson Hartle on 6/23/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit

protocol PlantCellDelegate {
    func timerDidFire(plant: Plant) -> Void
}

class UserPlantTableViewCell: UITableViewCell {

    @IBOutlet weak var plantName: UILabel!
    @IBOutlet weak var plantSpecies: UILabel!
    @IBOutlet weak var plantWasWateredButton: UIButton!
    @IBOutlet weak var waterPlantButton: UIButton!
    
    var plant: Plant? {
        didSet{
            updateViews()
        }
    }
    
    var delegate: PlantCellDelegate?

    var plantIsWatered: Bool = false
    
    @IBAction func waterPlantButtonTapped(_ sender: UIButton) {
        guard let plant = plant else { return }
        plant.isWatered.toggle()
        
        updateViews()
        
        runTimer()
        
    }
    
    private func runTimer() {
        
        guard let plant = plant else {return}
        let planth20 = Int(plant.h2ofrequency!)
        let plantH20Double = Double(planth20!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + plantH20Double) {
            plant.isWatered = false
            self.updateViews()
            self.delegate?.timerDidFire(plant: plant)
        }
    }
    
    private func updateViews() {
        guard let plant = plant else { return }
        
        plantName.text = plant.nickname
        plantSpecies.text = plant.species
        
        if plant.isWatered == false {
            waterPlantButton.isEnabled = true
            waterPlantButton.setImage(#imageLiteral(resourceName: "0000") , for: .normal)
        } else if plant.isWatered {
            waterPlantButton.isEnabled = false
            waterPlantButton.setImage( #imageLiteral(resourceName: "00001") , for: .normal)
        }
    }

    

}
