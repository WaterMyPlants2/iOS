//
//  TestingViewController.swift
//  WMP34
//
//  Created by Bradley Diroff on 6/22/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//
import UIKit

class TestingViewController: UIViewController {
    
    var collectionView: UICollectionView?
    
    let dangerCell = UICollectionViewCell()
    
    var logoutBarButtonItem: UIBarButtonItem?
    var addBarButtonItem: UIBarButtonItem?
    
    var plants = ["fern one", "fern two", "fern three", "fern four", "fern five", "fern six"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.systemGreen
        
        bringInCollectionView()
        bringInNavigationItems()
        
        dangerCell.backgroundColor = UIColor.red
        
        // Do any additional setup after loading the view.
    }
    
    func bringInNavigationItems() {
        
     //   self.navigationController?.delegate = self
        
        logoutBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutUser))
        logoutBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem  = logoutBarButtonItem!
        
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlant))
        addBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem  = addBarButtonItem!
        
    }
    
    @objc func addPlant() {
        performSegue(withIdentifier: "AddSegue", sender: nil)
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
        
   //     let sized = CGRect(x: 0.0, y: 0, width: Double(self.view.frame.maxX), height: Double(self.view.frame.height))
        
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
        
        let plant = plants[indexPath.item]
        
        cell.titleLabel.text = plant
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plants.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1  // Number of section
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let plant = plants[indexPath.item]
        
        performSegue(withIdentifier: "EditSegue", sender: plant)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= -104 {
            print("its not 0: \(scrollView.contentOffset.y)")
            logoutBarButtonItem?.tintColor = UIColor.systemGreen
            addBarButtonItem?.tintColor = UIColor.systemGreen
        } else {
            print("its 0")
            logoutBarButtonItem?.tintColor = UIColor.white
            addBarButtonItem?.tintColor = UIColor.white
        }

    }
    
}
