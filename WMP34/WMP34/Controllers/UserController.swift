//
//  UserController.swift
//  WMP34
// swiftlint:disable all
//  Created by Bradley Diroff on 6/23/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import Foundation
import CoreData

class UserController {
    let baseURL = URL(string: "https://jren-watermyplants.herokuapp.com")!
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    var token: LoginRepresentation?
    
    static let shared = UserController()
    
    var dataLoader: NetworkDataLoader
    
    init(dataLoader: NetworkDataLoader = URLSession.shared) {
        self.dataLoader = dataLoader
    }
    
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
        
        dataLoader.loadData(using: request) { (_, _, error) in
            if let error = error {
                NSLog("Error registering user: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            completion(.success(true))
        }
    }
    
    func loginUser(username: String, password: String,
                   completion: @escaping CompletionHandler = { _ in }) {
        let loginURL = URL(string: "/api/auth/login", relativeTo: baseURL)!
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let authentication = "lambda-client:lambda-secret"
        let encodedAuth = authentication.data(using: String.Encoding.utf8)!
        let base64Auth = encodedAuth.base64EncodedString()
        request.addValue("Basic \(base64Auth)", forHTTPHeaderField: "Authorization")
        let loginString = "grant_type=password&username=\(username)&password=\(password)"
        let loginStringData = loginString.data(using: String.Encoding.utf8)
        request.httpBody = loginStringData
        dataLoader.loadData(using: request) { (data, _, error) in
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
                self.token = try JSONDecoder().decode(LoginRepresentation.self, from: data)
                completion(.success(true))
            } catch {
                NSLog("Error decoding login response: \(error)")
                completion(.failure(.failedDecode))
                return
            }
            completion(.success(true))
        }
    }
}
