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
    
    @IBOutlet weak var plantNameTextField: UITextField!
    @IBOutlet weak var speciesTextField: UITextField!
    @IBOutlet weak var frequencyTextField: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
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
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        frequencyTextField.delegate = self
        
        pickerView.isHidden = true
        plantNameTextField.text = plant?.nickname
        speciesTextField.text = plant?.species
        frequencyTextField.text = determineFrequencyText()
        
        title = plant?.nickname ?? "Add a new plant"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //This is just to make it easier for user to input text.
        guard let plantNameTxtField = plantNameTextField.text else { return }
        if plantNameTxtField.isEmpty {
            plantNameTextField.becomeFirstResponder()
        }
        
    }
    
    // MARK: - Actions
    
    @IBAction func savePlantButton(_ sender: Any) {
        
        guard let commonName = plantNameTextField.text,
            let scientificName = speciesTextField.text else { return }
        
        if let plant = plant {
            plant.nickname = commonName
            plant.species = scientificName
            plant.h2ofrequency = determineFrequency()
            
            plantController?.sendPlantToServer(plant: plant, completion: { result in
                switch result {
                case .success(_):
                    print("Success")
                case .failure(_):
                    print("Failure")
                }
            })
        } else {
            let plant = Plant(nickname: commonName, species: scientificName, image: "", h2ofrequency: determineFrequency())
            
            plantController?.sendPlantToServer(plant: plant, completion: { result in
                switch result {
                case .success(_):
                    print("Success")
                case .failure(_):
                    print("Failure")
                }
            })
        }
        
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func determineFrequency() -> String {
        guard let frequency = frequencyTextField.text else { return "0" }
        
        switch frequency {
        case PickerOptions.onceADay.rawValue:
            return "86400"
        case PickerOptions.everyTwoDays.rawValue:
            return "172800"
        case PickerOptions.everyThreeDays.rawValue:
            return "259200"
        case PickerOptions.onceAWeek.rawValue:
            return "604800"
        case PickerOptions.demo.rawValue:
            return "5"
        default:
            return "0"
        }
    }
    
    private func determineFrequencyText() -> String? {
        guard let plant = plant else { return nil }
        
        switch plant.h2ofrequency {
        case "86400":
            return PickerOptions.onceADay.rawValue
        case "172800":
            return PickerOptions.everyTwoDays.rawValue
        case "259200":
            return PickerOptions.everyThreeDays.rawValue
        case "604800":
            return PickerOptions.onceAWeek.rawValue
        case "5":
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
        frequencyTextField.text = pickerData[row]
        pickerView.isHidden = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        pickerView.isHidden = false
        return false
    }
}

