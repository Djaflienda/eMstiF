//
//  CartWorker.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 10/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

class CartService {
    
    private let networkManager = NetworkManager()
    
    func getCartItems(complition: @escaping  (_ data: [CartItem]?, _ error: String?) -> Void) {
        imageCache.removeAllObjects()
        networkManager.getCartItems(page: 1, status: "FM") { (items, error) in
            complition(items, error)
        }
    }
    
    func removeItemFromCart(id: Int, complition: @escaping  (_ error: NetworkManager.Result<String>) -> Void) {
        networkManager.removeFromCart(id: id) { (result) in
            complition(result)
        }
    }
}
