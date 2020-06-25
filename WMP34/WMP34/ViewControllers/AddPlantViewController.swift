//
//  AddPlantViewController.swift
//  WMP34
//
//  Created by Bradley Diroff on 6/25/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit

class AddPlantViewController: UIViewController {
    
    var plantController: PlantController?
    var plant: Plant?
    var wasEdited = false
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        makeBackground()
        setupObjects()
        
        picker.delegate = self
        picker.dataSource = self
        frequency.delegate = self
        
        picker.isHidden = true
        nickName.text = plant?.nickname
        speciesName.text = plant?.species
        frequency.text = determineFrequencyText()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    @objc func savePlantButton() {
        guard let commonName = nickName.text,
            let scientificName = speciesName.text else { return }
        
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
        self.dismiss(animated: true, completion: nil)
    }
    
    private func determineFrequency() -> String {
        guard let frequency = frequency.text else { return "0" }
        
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
    
    var formView: UIView = {
        
        let aView = UIView()

        aView.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        aView.layer.cornerRadius = 20.0 //60.0
        aView.layer.borderWidth = 2.0
        aView.layer.borderColor = UIColor.white.cgColor
        aView.layer.masksToBounds = true

        aView.layer.shadowColor = UIColor.white.cgColor
 //       aView.layer.shadowColor = UIColor.systemGreen.cgColor
        aView.layer.shadowOffset = CGSize(width: 0, height: 0)//2.0)
        aView.layer.shadowRadius = 1.0
        aView.layer.shadowOpacity = 0.8
        aView.layer.masksToBounds = false
        aView.layer.shadowPath = UIBezierPath(roundedRect: aView.bounds, cornerRadius: aView.layer.cornerRadius).cgPath

       // aView.alpha = 0
        
        return aView
    }()
    
    var nickName: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 250, height: 30))
        textField.borderStyle = .roundedRect
    //    textField.translatesAutoresizingMaskIntoConstraints  = false
        textField.placeholder = "Nickname"
        textField.autocorrectionType = .no
        return textField
    }()
    
    var speciesName: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 250, height: 30))
        textField.borderStyle = .roundedRect
   //     textField.translatesAutoresizingMaskIntoConstraints  = false
        textField.placeholder = "Species Name"
        textField.autocorrectionType = .no
        return textField
    }()
    
    var frequency: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 250, height: 30))
        textField.borderStyle = .roundedRect
  //      textField.translatesAutoresizingMaskIntoConstraints  = false
        textField.placeholder = "Frequency"
        textField.autocorrectionType = .no
        return textField
    }()
    
    var nameLabel:UILabel = {
        let ccgRect = CGRect(x:0, y: 0, width: 30 , height: 15)
        let label = UILabel(frame: ccgRect)
        label.text = "Nickname"
        label.textColor = UIColor.black
        
        guard let customFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 10) else {
            fatalError("No font"
            )
        }
        
        label.font = customFont
        label.adjustsFontForContentSizeCategory = false//true
        
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        return label
    }()
    
    var speciesLabel:UILabel = {
        let ccgRect = CGRect(x:0, y: 0, width: 30 , height: 15)
        let label = UILabel(frame: ccgRect)
        label.textColor = UIColor.black
        label.text = "Species"
        
        guard let customFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 10) else {
            fatalError("No font"
            )
        }
        
        label.font = customFont
        label.adjustsFontForContentSizeCategory = false//true
        
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        return label
    }()
    
    var frequencyLabel:UILabel = {
         let ccgRect = CGRect(x:0, y: 0, width: 30 , height: 15)
        let label = UILabel(frame: ccgRect)
        label.textColor = UIColor.black
        label.text = "Frequency"
        
        guard let customFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 10) else {
            fatalError("No font"
            )
        }
        
        label.font = customFont
        label.adjustsFontForContentSizeCategory = false//true
        
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    var saveButton: UIButton = {
        let cgrec = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        let button = UIButton(frame: cgrec)
        button.setImage(UIImage(named: "waterElement"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
  //      button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(savePlantButton), for: .touchUpInside)
        
        return button
    }()
    
    var picker: UIPickerView = {
        let ccgRect = CGRect(x:0, y: 0, width: 250 , height: 80)
        let thePicker = UIPickerView()

 //       thePicker.translatesAutoresizingMaskIntoConstraints = false
        return thePicker
    }()
    
    func setupObjects() {
        
        self.view.addSubview(formView)
        formView.center.x = self.view.frame.midX
        formView.center.y = self.view.frame.midY - 50
        
//        self.view.addSubview(nameLabel)
//        nickName.center.x = self.view.frame.midX
//        nickName.center.y = self.view.frame.midY - 160
        
        self.view.addSubview(nickName)
        nickName.center.x = self.view.frame.midX
        nickName.center.y = self.view.frame.midY - 190
        
//        self.view.addSubview(speciesLabel)
//        speciesName.center.x = self.view.frame.midX
//        speciesName.center.y = self.view.frame.midY - 120
        
        self.view.addSubview(speciesName)
        speciesName.center.x = self.view.frame.midX
        speciesName.center.y = self.view.frame.midY - 150
        
//        self.view.addSubview(frequencyLabel)
//        frequency.center.x = self.view.frame.midX
//        frequency.center.y = self.view.frame.midY - 80
        
        self.view.addSubview(frequency)
        frequency.center.x = self.view.frame.midX
        frequency.center.y = self.view.frame.midY - 110
        
        self.view.addSubview(picker)
        picker.center.x = self.view.frame.midX
        picker.center.y = self.view.frame.midY
        
        self.view.addSubview(saveButton)
        saveButton.center.x = self.view.frame.midX + 100
        saveButton.center.y = self.view.frame.midY - 250
        
        /*
        formView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        formView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        formView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        formView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40).isActive = true
        
        self.view.addSubview(nickName)
        NSLayoutConstraint.activate([
            
        formView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
        nickName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        nickName.widthAnchor.constraint(equalToConstant: self.view.frame.width - 30),
        nickName.heightAnchor.constraint(equalToConstant: 20)
        ])
        */
    }
    
    func makeBackground() {
        self.view.backgroundColor = .clear
        
        let sized = CGRect(x: 0.0, y: 0, width: Double(self.view.frame.maxX), height: Double(self.view.frame.height))
        
        let blackView = UIView()
        blackView.backgroundColor = UIColor.black
        blackView.frame = sized
        blackView.alpha = 0.2
        self.view.addSubview(blackView)
        
        let backGroundImg = UIImageView()
        backGroundImg.image = UIImage(named: "leaftiny")
        backGroundImg.contentMode = .scaleAspectFill
        backGroundImg.frame = sized
        backGroundImg.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backGroundImg)
        
    }

}


extension AddPlantViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
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
        picker.isHidden = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        picker.isHidden = false
        return false
    }
}

