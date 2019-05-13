//
//  Clothes.swift
//  FitsMe
//
//  Created by Sergey Romanchuk on 11/02/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit



struct ClothesDataResponse: Codable {
    
    var response: ClothesResponse?
}

struct FavoriteDataResponse: Codable {

    var response: FavoriteResponse?
}

struct ClothesResponse: Codable {
    
    var count: Int?
    var current: Int?
    var next: Int? = 1
    var previous: Int?
    var items: [Cloth]?
    var detail: String?
}

struct FavoriteResponse: Codable {

    var count: Int?
    var current: Int?
    var next: Int? = 1
    var previous: Int?
    var items: [FavoriteModel?]?
    var detail: String?

}

struct FavoriteModel: Codable {
    
    var id: Int
    var clothe: Cloth
    var add_datetime: String
    var liked: Bool
    var in_cart: Bool
}

struct Cloth: Codable {
    
    static var clothesPage: Int = 1
    
    var id: Int
    var brand: String
    var name: String
    var description: String
    var material: [String]
    var pics: [Pics]
    var available_sizes_id: [Int]
    var clothe_type: ClothType
    var size_in_stock: String
}

struct ClothType: Codable {
    
    var title: String
    var type: String
}

struct Pics: Codable {
    
    var id: Int
    var url: String
}

struct ClothError: Codable {
    
    let code: Int
    let message: String
}

