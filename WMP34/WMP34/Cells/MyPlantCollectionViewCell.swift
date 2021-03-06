//
//  MyPlantCollectionViewCell.swift
//  WMP34
//
//  Created by Bradley Diroff on 6/22/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit

class MyPlantCollectionViewCell: UICollectionViewCell {
    var wetOne: UIImageView = {
         let imageView = UIImageView()
         imageView.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
         imageView.widthAnchor.constraint(equalToConstant: 10.0).isActive = true
         imageView.image = UIImage(named: "fullDrop")
         return imageView
     }()
     var wetTwo: UIImageView = {
         let imageView = UIImageView()
         imageView.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
         imageView.widthAnchor.constraint(equalToConstant: 10.0).isActive = true
         imageView.image = UIImage(named: "emptyDrop")
         return imageView
     }()
     var wetThree: UIImageView = {
         let imageView = UIImageView()
         imageView.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
         imageView.widthAnchor.constraint(equalToConstant: 10.0).isActive = true
         imageView.image = UIImage(named: "emptyDrop")
         return imageView
     }()
     var wetFour: UIImageView = {
         let imageView = UIImageView()
         imageView.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
         imageView.widthAnchor.constraint(equalToConstant: 10.0).isActive = true
         imageView.image = UIImage(named: "emptyDrop")
         return imageView
     }()
     var wetFive: UIImageView = {
         let imageView = UIImageView()
         imageView.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
         imageView.widthAnchor.constraint(equalToConstant: 10.0).isActive = true
         imageView.image = UIImage(named: "emptyDrop")
         return imageView
     }()
     override init(frame: CGRect) {
         super.init(frame: frame)
         self.contentView.layer.cornerRadius = 20.0 //60.0
         self.contentView.layer.borderWidth = 2.0
         self.contentView.layer.borderColor = UIColor.white.cgColor
         self.contentView.layer.masksToBounds = true
         self.layer.shadowColor = UIColor.white.cgColor
         self.layer.shadowOffset = CGSize(width: 0, height: 0)//2.0)
         self.layer.shadowRadius = 1.0
         self.layer.shadowOpacity = 0.7
         self.layer.masksToBounds = false
         self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                              cornerRadius: self.contentView.layer.cornerRadius).cgPath
         let allStack = UIStackView()
         allStack.axis = NSLayoutConstraint.Axis.horizontal
         allStack.distribution = UIStackView.Distribution.fillEqually
         allStack.alignment = UIStackView.Alignment.center
         allStack.spacing = 5.0
         allStack.addArrangedSubview(titleLabel)
         allStack.addArrangedSubview(levelText)
         allStack.addArrangedSubview(wetStack)
         let doubleStack = UIStackView()
         doubleStack.axis  = NSLayoutConstraint.Axis.vertical
         doubleStack.distribution  = UIStackView.Distribution.equalSpacing
         doubleStack.alignment = UIStackView.Alignment.center
         doubleStack.spacing = 5.0
         imgView.widthAnchor.constraint(equalToConstant: 250).isActive = true
         imgView.heightAnchor.constraint(equalToConstant: 250).isActive = true
         doubleStack.addArrangedSubview(imgView)
         doubleStack.addArrangedSubview(allStack)
         doubleStack.translatesAutoresizingMaskIntoConstraints = false
         addSubview(doubleStack)
         doubleStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
         doubleStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
         doubleStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
         doubleStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
         doubleStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
     }
     let backImg: UIView = {
         let viewImg = UIView()
         viewImg.backgroundColor = UIColor.white
         viewImg.alpha = 0.9
         return viewImg
     }()
     let imgView: UIImageView = {
         let cgrec = CGRect(x: 10, y: 10, width: 140, height: 60)
         let imageView = UIImageView()
         imageView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.image = UIImage(named: "continueWithFacebook")
         imageView.contentMode = .scaleAspectFit //.center
         imageView.clipsToBounds = true
         imageView.layer.cornerRadius = 8.0
         return imageView
     }()
     var wetStack: UIStackView {
         let stackView   = UIStackView()
         stackView.axis  = NSLayoutConstraint.Axis.horizontal
         stackView.distribution  = UIStackView.Distribution.equalSpacing
         stackView.alignment = UIStackView.Alignment.center
         stackView.spacing   = 8.0
         stackView.addArrangedSubview(wetOne)
         stackView.addArrangedSubview(wetTwo)
         stackView.addArrangedSubview(wetThree)
         stackView.addArrangedSubview(wetFour)
         stackView.addArrangedSubview(wetFive)
         stackView.translatesAutoresizingMaskIntoConstraints = false
         stackView.frame = CGRect(x: 100, y: 50, width: 50, height: 50)
         return stackView
     }
     var titleLabel: UILabel = {
         let ccgRect = CGRect(x: 100, y: 20,
                              width: 100, height: 40)
         let label = UILabel(frame: ccgRect)
         label.textColor = UIColor.black
         guard let customFont = UIFont(name: "Thonburi-Bold", size: 14/*UIFont.labelFontSize*/) else {
             fatalError("No font"
             )
         }
         label.font = customFont//UIFontMetrics.default.scaledFont(for: customFont)
         label.adjustsFontForContentSizeCategory = false//true
         label.textAlignment = .center
         label.lineBreakMode = .byWordWrapping
         label.numberOfLines = 2
         return label
     }()
     var levelText: UILabel = {
         let ccgRect = CGRect(x: 100, y: 20,
                              width: 40, height: 20)
         let label = UILabel(frame: ccgRect)
         label.textColor = UIColor.black
         guard let customFont = UIFont(name: "Thonburi-Light", size: 10/*UIFont.labelFontSize*/) else {
             fatalError("No font"
             )
         }
         label.font = customFont
         label.textAlignment = .center
         label.lineBreakMode = .byWordWrapping
         label.numberOfLines = 1
         label.text = "Wetness Level"
         return label
     }()
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}
