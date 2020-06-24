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
    let baseURL = URL(string: "https://jren-watermyplants.herokuapp.com")!
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    static var token: LoginRepresentation?
    
    static let shared = UserController()
    
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
        
        let authentication = "lambda-client:lambda-secret"
        let encodedAuth = authentication.data(using: String.Encoding.utf8)!
        let base64Auth = encodedAuth.base64EncodedString()
        
        request.addValue("Basic \(base64Auth)", forHTTPHeaderField: "Authorization")

//            let login = ["grant_type" : "password", "username" : username, "password" : password]
//            request.httpBody = try JSONEncoder().encode(login)
//            print(String(data: request.httpBody!, encoding: String.Encoding.utf8))
//            let jsonData = try JSONSerialization.data(withJSONObject: login, options: .prettyPrinted)
//            request.httpBody = jsonData
            
        let loginString = "grant_type=password&username=\(username)&password=\(password)"
        let loginStringData = loginString.data(using: String.Encoding.utf8)
            
        request.httpBody = loginStringData
        
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
                Self.token = try JSONDecoder().decode(LoginRepresentation.self, from: data)
                completion(.success(true))
            } catch {
                NSLog("Error decoding login response: \(error)")
                completion(.failure(.failedDecode))
                return
            }
            
            completion(.success(true))
        }.resume()
    }
}
