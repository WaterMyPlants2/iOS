//
//  PlantController.swift
//  WMP34
//
//  Created by Bradley Diroff on 6/23/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import Foundation
import CoreData

class PlantController {
    
    let userController = UserController.shared
    
    let baseURL = URL(string: "https://jren-watermyplants.herokuapp.com")!
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    init() {
        
    }
    
    // MARK: - API Functions
    
    func fetchPlantsFromServer(completion: @escaping CompletionHandler = { _ in }) {
        /*
         GET - /api/plants - return a list of plants of current user
         */
    }
    
    func sendPlantToServer(plant: Plant, completion: @escaping CompletionHandler = { _ in }) {
        guard let token = userController.token?.access_token else {
            NSLog("Token object was found to be nil, aborting")
            return
        }
        
        let requestUrl = URL(string: "api/plants", relativeTo: baseURL)!
        
        var request = URLRequest(url: requestUrl)
        request.addValue("application/json", forHTTPHeaderField:
        "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            //request.httpBody = try JSONEncoder().encode(plant)
        } catch {
            NSLog("Error encoding plant \(plant): \(error)")
        }
        
    }
    
    func deletePlantFromServer(plant: Plant, completion: @escaping CompletionHandler = { _ in }) {
        /*
         DELETE - /api/plants/{plantid} - Delete the plant by plant id
        */
    }
    
    func updatePlantOnServer(plant: Plant, completion: @escaping CompletionHandler = { _ in }) {
        /*
         PUT - /api/plants/{plantid} - update a plant given in the request body
         */
    }
    
    // MARK: - Utility Functions
}

