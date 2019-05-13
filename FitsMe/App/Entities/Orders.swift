//
//  BasketCard.swift
//  FitsMe
//
//  Created by Sergey Romanchuk on 01/04/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//


import UIKit

struct CartData: Codable{
    var response: CartResponse?
    var error: CartError?
}

struct CartResponse: Codable {
    
    var count: Int?
    var current: Int?
    var next: Int?
    var previous: Int?
    var items: [CartItems]
    
}

struct CartItems: Codable {
    
    var id: Int?
    var city: String?
    var street: String?
    var apartment: String?
    var tel: String?
    var house_number: String?
    var created: String?
    var updated: String?
    var status: String?
    var orderitems: [CartItem]
}

struct CartItem: Codable{
    var id: Int
    var order: Int?
    var clothe: Cloth
    var price: Int?
//    var quantity: Int?
}


struct CartError: Codable {
    
    let code: Int
    let message: String
}
