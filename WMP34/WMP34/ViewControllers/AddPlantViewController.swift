//
//  AddPlantViewController.swift
//  WMP34
//
//  Created by Bradley Diroff on 6/25/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit

class AddPlantViewController: UIViewController {
    
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
        return textField
    }()
    
    var speciesName: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 250, height: 30))
        textField.borderStyle = .roundedRect
   //     textField.translatesAutoresizingMaskIntoConstraints  = false
        textField.placeholder = "Species Name"
        return textField
    }()
    
    var frequency: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 250, height: 30))
        textField.borderStyle = .roundedRect
  //      textField.translatesAutoresizingMaskIntoConstraints  = false
        textField.placeholder = "Frequency"
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
    
    var picker: UIPickerView = {
        let ccgRect = CGRect(x:0, y: 0, width: 250 , height: 80)
        let thePicker = UIPickerView()

 //       thePicker.translatesAutoresizingMaskIntoConstraints = false
        return thePicker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        makeBackground()
        setupObjects()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
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

