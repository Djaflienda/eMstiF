//
//  CartModels.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 10/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

enum Cart {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getCartItems
        case removeItemFromCart(index: Int)
      }
    }
    struct Response {
      enum ResponseType {
        case prepareCart(items: [CartItem])
        case prepareAlert
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case presentCart(items: [Cloth])
        case presentAlert
      }
    }
  }
  
}
