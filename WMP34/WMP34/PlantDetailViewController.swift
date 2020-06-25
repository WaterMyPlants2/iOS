//
//  PlantDetailViewController.swift
//  WMP34
//
//  Created by Kelson Hartle on 6/23/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit

class PlantDetailViewController: UIViewController {
    
    
    var plantController: PlantController?
    var plant: Plant?
    var wasEdited = false
    
    @IBOutlet weak var plantName: UITextField!
    @IBOutlet weak var scientificName: UITextField!
    @IBOutlet weak var frequency: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        navigationItem.rightBarButtonItem = editButtonItem
        updateViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if wasEdited {
            guard let plantName = plantName.text,
            !plantName.isEmpty,
                let plant = plant else { return }
            
            let h20Frequency = frequency.text
            let scientficName = scientificName.text
            plant.nickname = plantName
            plant.h2ofrequency = h20Frequency
            plant.species = scientficName
            
            plantController?.sendPlantToServer(plant: plant)
            do {
                try CoreDataStack.shared.save()
            } catch {
                NSLog("Error saving managed object context (during task edit): \(error)")
                
            }
        }
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing { wasEdited = true }
        
        plantName.isUserInteractionEnabled = editing
        frequency.isUserInteractionEnabled = editing
        scientificName.isUserInteractionEnabled = editing
        
        navigationItem.hidesBackButton = editing
    }
    
    func updateViews() {
        scientificName.text = plant?.species
        scientificName.isUserInteractionEnabled = isEditing
        
        frequency.text = plant?.h2ofrequency
        frequency.isUserInteractionEnabled = isEditing
        
        plantName.text = plant?.nickname
        plantName.isUserInteractionEnabled = isEditing
        
        
    }
    
    
    
    
    
    
    
    
    
    enum PickerOptions: String, CaseIterable {
        case onceADay = "Once a day"
        case everyTwoDays = "Every two days"
        case everyThreeDays = "Every three days"
        case onceAWeek = "Once a week"
        case demo = "Demo Purposes: 5 seconds"
    }
    
    private var pickerData: [String] {
        var pickerData = [String]()
        for data in PickerOptions.allCases {
            pickerData.append(data.rawValue)
        }
        return pickerData
    }
    
    private func determineFrequency() -> Double {
        guard let frequency = frequency.text else { return 0 }
        
        switch frequency {
        case PickerOptions.onceADay.rawValue:
            return 86400
        case PickerOptions.everyTwoDays.rawValue:
            return 172800
        case PickerOptions.everyThreeDays.rawValue:
            return 259200
        case PickerOptions.onceAWeek.rawValue:
            return 604800
        case PickerOptions.demo.rawValue:
            return 5
        default:
            return 0
        }
    }
    
    private func determineFrequencyText() -> String? {
        guard let plant = plant else { return nil }
        
        guard let plantH20 = Int(plant.h2ofrequency!) else { return nil}
        
        switch plantH20 {
        case 86400:
            return PickerOptions.onceADay.rawValue
        case 172800:
            return PickerOptions.everyTwoDays.rawValue
        case 259200:
            return PickerOptions.everyThreeDays.rawValue
        case 604800:
            return PickerOptions.onceAWeek.rawValue
        case 5:
            return PickerOptions.demo.rawValue
        default:
            return nil
        }
    }
}

extension PlantDetailViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        frequency.text = pickerData[row]
        pickerView.isHidden = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        frequency.isHidden = false
        return false
    }
}
