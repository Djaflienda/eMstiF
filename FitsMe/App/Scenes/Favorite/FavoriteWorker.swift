//
//  FavoriteWorker.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 10/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

class FavoriteService {
    
    private let networkManager = NetworkManager()
    private var paginationData = APIPaginationData.shared.favoriteData
    
    func getFavoriteItems(complition: @escaping  (_ data: [FavoriteModel]?, _ error: String?) -> Void) {
        imageCache.removeAllObjects()
        
        guard let page = paginationData.next else { return }
        networkManager.getFavoriteItems(page: page) { (items, error) in
            complition(items, error)
        }
    }
    
    func removeItemFromViewed(id: Int, method: HTTPMethod, complition: @escaping  (_ error: NetworkManager.Result<String>) -> Void) {
        networkManager.removeFromViewed(id: id, method: method) { (result) in
            complition(result)
        }
    }
    
    func moveToCart(targetId: Int, quantity: Int, complition: @escaping  (_ error: NetworkManager.Result<String>) -> Void) {
        networkManager.moveToCart(clothID: targetId, quantity: quantity) { (result) in
            complition(result)
        }
    }
}
