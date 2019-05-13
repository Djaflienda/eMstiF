//
//  CardsWorker.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 04/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

class CardsService {
    
    private let networkManager = NetworkManager()
    private var paginationData = APIPaginationData.shared.cardsData
    
    func getCards(complition: @escaping  (_ data: [Cloth]?, _ error: String?) -> Void) {
        imageCache.removeAllObjects()
        
        guard let page = paginationData.next else { return }
        networkManager.getClothes(page: page) { (recievedData, error)  in
            complition(recievedData, error)
        }
    }
    
    func mark(card: Int, asLiked: Bool, complition: @escaping  (_ error: String?) -> Void) {
        
        //here is where networking manager should do his job))
        networkManager.markCard(clotheId: card, asLiked: asLiked) { (error) in
            complition(error)
        }
    }
}
