//
//  ClothesSize.swift
//  FitsMe
//
//  Created by Sergey Romanchuk on 21/04/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

import UIKit

struct SizeDataResponse: Codable {
    
    var response:[ClothesSize?]
}


struct ClothesSize: Codable {
    var id: Int
    var int: String
    var ru: Int
    var eu: Int
    var fr: Int
    var it: Int
    var us: Int
    var uk: Int
    var chest_low: String
    var waist_low: String
    var hips_low: String
    var sleeve_low: String
    var chest_high: String
    var waist_high: String
    var hips_high: String
    var sleeve_high: String
    
}
