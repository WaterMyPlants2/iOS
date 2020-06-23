//
//  NetworkError.swift
//  WMP34
//
//  Created by Bradley Diroff on 6/23/20.
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
