//
//  UserController.swift
//  WMP34
//
//  Created by Bradley Diroff on 6/23/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import Foundation
import CoreData

class UserController {
    let baseURL = URL(string: "https://jren-watermyplants.herokuapp.com/")!
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    // MARK: - API Functions
    func registerUser(username: String, password: String, phonenumber: String,
                      completion: @escaping CompletionHandler = { _ in }) {
        let registerURL = URL(string: "/api/auth/register", relativeTo: baseURL)!
        
        var request = URLRequest(url: registerURL)
        request.httpMethod = "POST"
        request.addValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        
        do {
            let userRepresentation = UserRepresentation(username: username,
                                                        phonenumber: phonenumber,
                                                        password: password)
            request.httpBody = try JSONEncoder().encode(userRepresentation)
        } catch {
            NSLog("Error encoding user: \(error)")
            completion(.failure(.failedEncode))
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                NSLog("Error registering user: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            completion(.success(true))
        }.resume()
    }
    
    func loginUser(username: String, password: String,
                   completion: @escaping CompletionHandler = { _ in }) {
        let loginURL = URL(string: "/api/auth/login", relativeTo: baseURL)!
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        do {
            let loginRepresentation = LoginRepresentation(username: username,
                                                          password: password)
            request.httpBody = try JSONEncoder().encode(loginRepresentation)
        } catch {
            NSLog("Error encoding user \(error)")
            completion(.failure(.failedEncode))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Error registering user: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from server while logging in")
                completion(.failure(.noData))
                return
            }
            
            do {
                // decode/set bearer token here
            } catch {
                NSLog("Errpr decoding bearer object: \(error)")
                completion(.failure(.failedDecode))
                return
            }
            
            completion(.success(true))
        }.resume()
    }
}
