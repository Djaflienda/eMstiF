//
//  FavoriteInteractor.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 10/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

protocol FavoriteBusinessLogic {
    var favoriteItems: [FavoriteModel] { get }
    func makeRequest(request: Favorite.Model.Request.RequestType)
}

class FavoriteInteractor: FavoriteBusinessLogic {
    
    var presenter: FavoritePresentationLogic?
    var service: FavoriteService?
    
    var favoriteItems = [FavoriteModel]()
    
    func makeRequest(request: Favorite.Model.Request.RequestType) {
        if service == nil {
            service = FavoriteService()
        }
        switch request {
        case .getFavoriteItems:
            service?.getFavoriteItems(complition: { (favoriteItems, error) in
                if let _ = error {
                    return
                }
                if let favoriteItems = favoriteItems, !favoriteItems.isEmpty {
                    self.favoriteItems.removeAll()
                    self.favoriteItems.append(contentsOf: favoriteItems)
                    self.presenter?.presentData(response: .prepare(favorite: favoriteItems))
                } else {
                    self.presenter?.presentData(response: .prepareAlert)
                }
            })
        case .removeItemFromFavorite(let index):
            let target = favoriteItems.remove(at: index)
            service?.removeItemFromViewed(id: target.id, method: .put, complition: { (result) in
                switch result {
                case .success:
                    print("CART ITEM WAS REMOVED SUCCESSFULLY")
                    if self.favoriteItems.isEmpty {
                        self.presenter?.presentData(response: .prepareAlert)
                    }
                case .failure(_):
                    //have to fix all error here
                    print("CART ITEM WAS NOT REMOVED")
                }
            })
        case .moveItemToCart(let targetId, let quantity):
            service?.moveToCart(targetId: targetId, quantity: quantity, complition: { (result) in
                switch result {
                case .success:
                    print("ITEM WAS MOVED TO CART SUCCESSFULLY")
//                    if self.favoriteItems.isEmpty {
//                        self.presenter?.presentData(response: .prepareAlert)
//                    }
                case .failure(_):
                    //have to fix all error here
                    print("ITEM WAS NOT MOVED TO CART")
                }
            })
        }
    }
    
}
