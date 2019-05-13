//
//  CardsInteractor.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 04/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

protocol CardsBusinessLogic {
    func makeRequest(request: Cards.Model.Request.RequestType)
}

class CardsInteractor: CardsBusinessLogic {
    
    var presenter: CardsPresentationLogic?
    var service: CardsService?
    
    private var clothArray = [Cloth]()
    
    func makeRequest(request: Cards.Model.Request.RequestType) {
        if service == nil {
            service = CardsService()
        }
        
        switch request {
        case .getCards:
            service?.getCards(complition: { (cloth, error) in
                if let error = error {
                    self.presenter?.presentData(response: .prepareAlert(error: error))
                    return
                }
                guard var cloth = cloth, !cloth.isEmpty else {
                    self.presenter?.presentData(response: .prepareAlert(error: nil))
                    return
                }
                if !self.clothArray.isEmpty { cloth.remove(at: 0) }
                self.clothArray.append(contentsOf: cloth)
                self.presenter?.presentData(response: .prepareCards(cards: cloth))
            })
            
        case .markCard(let isLiked):
            guard let targetCard = clothArray.first else { return }
            service?.mark(card: targetCard.id, asLiked: isLiked, complition: { (error) in
//                if let _ = error {
//                    //in case of error we should store this cardID to send request later
//                }
                self.clothArray.remove(at: 0)
                self.presenter?.presentData(response: .prepareNothing)
            })
        }
    }
}
