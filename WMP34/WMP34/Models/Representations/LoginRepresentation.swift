//
//  LoginRepresentation.swift
//  WMP34
//
//  Created by Bradley Diroff on 6/23/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import Foundation

struct LoginRepresentation: Codable {
    let access_token: String
    let token_type: String
    let scope: String
}
