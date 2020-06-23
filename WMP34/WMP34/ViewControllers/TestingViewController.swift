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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.systemGreen
        
        bringInCollectionView()
        
        dangerCell.backgroundColor = UIColor.red
        
        // Do any additional setup after loading the view.
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
        
   //     let sized = CGRect(x: 0.0, y: 77, width: Double(self.view.frame.maxX), height: Double(self.view.frame.height - 126))
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
        print("ok it's checking for cell data")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPlantCell", for: indexPath) as? MyPlantCollectionViewCell else { return dangerCell}
        
        cell.titleLabel.text = "TESTING PLANT NAME"
        cell.imgView.image = UIImage(named: "vector-graphics-stock-photography-illustration-image-garden-png-favpng-WUcprivFQFnW9UrwBh2vaxf0r")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1  // Number of section
    }
    
}
