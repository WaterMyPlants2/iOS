//
//  NetworkDataLoader.swift
//  WMP34
//
//  Created by Ezra Black on 6/22/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import Foundation
protocol NetworkDataLoader {
    func loadData(using request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}
