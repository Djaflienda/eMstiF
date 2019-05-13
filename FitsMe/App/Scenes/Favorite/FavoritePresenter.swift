//
//  FavoritePresenter.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 10/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

protocol FavoritePresentationLogic {
  func presentData(response: Favorite.Model.Response.ResponseType)
}

class FavoritePresenter: FavoritePresentationLogic {
  weak var viewController: FavoriteDisplayLogic?
  
  func presentData(response: Favorite.Model.Response.ResponseType) {
    switch response {case .prepare(let favorite):
        let favoriteArray = favorite.map({ (favorite) -> Cloth in
            return favorite.clothe
        })
        DispatchQueue.main.async {
            self.viewController?.displayData(viewModel: .presentFavorite(items: favoriteArray))
        }
    case .prepareAlert:
        DispatchQueue.main.async {
            self.viewController?.displayData(viewModel: .presentAlert)
        }
    }
  }
  
}
