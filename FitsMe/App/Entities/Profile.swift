//
//  Profile.swift
//  FitsMe
//
//  Created by Sergey Romanchuk on 05/05/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

struct ProfileResponse: Codable {
    let response: Profile?
}

struct Profile: Codable {
    let tel: String
    let street: String
    let house_number: String
    let apartment: String
    let top_size: String
    let bottom_size: String
}
