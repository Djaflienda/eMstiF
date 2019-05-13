//
//  FavoriteModels.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 10/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

enum Favorite {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getFavoriteItems
        case removeItemFromFavorite(index: Int)
        case moveItemToCart(targetId: Int, quantity: Int)
      }
    }
    struct Response {
      enum ResponseType {
        case prepare(favorite: [FavoriteModel])
        case prepareAlert
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case presentFavorite(items: [Cloth])
        case presentAlert
      }
    }
  }
  
}
