//
//  User.swift
//  FitsMe
//
//  Created by Тигран Хачатурян on 24/01/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

protocol UserProtocol {
    var token: String { get }
    var login: String { get }
}

class User: UserProtocol {
    let token: String
    let login: String
    
    init(token: String,
         login: String) {
        self.token = token
        self.login = login
    }
}
