//
//  Token.swift
//  FitsMe
//
//  Created by Тигран Хачатурян on 21/01/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

struct TokenResponse: Codable {
    let response: TokenResult?
    let error: ErrorResult?
}

struct TokenResult: Codable {
    let token: String
    
}

struct ErrorResult: Codable {
    let code: Int
    let message: String
}
