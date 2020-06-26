//
//  MockDataLoading.swift
//  WMP34
//
//  Created by Ezra Black on 6/25/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import Foundation

class MockDataLoader: NetworkDataLoader {
    
    let data: Data?
    let error: Error?
    let response: URLResponse?
    
    internal init(data: Data?, error: Error?, response: URLResponse?) {
        self.data = data
        self.error = error
        self.response = response
    }
    
    func loadData(using request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completion(self.data, self.response, self.error)
    }
    
    func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {
            completion(self.data, self.error)
        }
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {
            completion(self.data, self.error)
        }
    }
}
