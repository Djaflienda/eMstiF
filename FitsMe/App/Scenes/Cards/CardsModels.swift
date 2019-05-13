//
//  CardsModels.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 04/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

enum Cards {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getCards
        case markCard(asLiked: Bool)
      }
    }
    struct Response {
      enum ResponseType {
        case prepareCards(cards: [Cloth])
        case prepareAlert(error: String?)
        case prepareNothing
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case presentCards(cards: [ClothCard])
        case presentAlert(alert: String?)
        case presentNothing
      }
    }
  }
  
}
