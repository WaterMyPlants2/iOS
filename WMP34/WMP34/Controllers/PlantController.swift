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
    var plants: [PlantRepresentation] = []
    
    let baseURL = URL(string: "https://jren-watermyplants.herokuapp.com")!
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    init() {
        fetchPlantsFromServer()
    }
    
    // MARK: - API Functions
    
    func fetchPlantsFromServer(completion: @escaping CompletionHandler = { _ in }) {

        guard let token = userController.token?.access_token else {
            NSLog("Token object was found to be nil, aborting")
            return
        }
        
        let requestUrl = URL(string: "/api/plants", relativeTo: baseURL)!
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error fetching plants: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from API")
                completion(.failure(.noData))
                return
            }
            
            do  {
                let plantRepresentations = Array(
                    try JSONDecoder().decode([PlantRepresentation].self, from: data))
                
                try self.updatePlants(with: plantRepresentations)
                self.plants = plantRepresentations
            } catch {
                NSLog("Error decoding plants from API: \(error)")
                completion(.failure(.failedDecode))
            }
        }.resume()
    }
    
    func sendPlantToServer(plant: PlantRepresentation, completion: @escaping CompletionHandler = { _ in }) {
        guard let token = userController.token?.access_token else {
            NSLog("Token object was found to be nil, aborting")
            return
        }
        
        let requestUrl = URL(string: "api/plants", relativeTo: baseURL)!
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField:
        "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONEncoder().encode(plant)
        } catch {
            NSLog("Error encoding plant \(plant): \(error)")
            completion(.failure(.failedEncode))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Error sending plant to server \(plant): \(error)")
                completion(.failure(.otherError))
                return
            }
            
            completion(.success(true))
        }.resume()
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
    private func updatePlants(with representations: [PlantRepresentation]) throws {
        /*
         private func updatePlants()
         
         implement logic to update locally stored plants with data retrieved from api
         */
        
        //let plantsToFetch = representations.compactMap { $0.nickname }
        
    }
}

