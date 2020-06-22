//
//  NetworkError.swift
//  WMP34
//
//  Created by Vincent Hoang on 6/22/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noIdentifier
    case otherError
    case noData
    case failedDecode
    case failedEncode
}
