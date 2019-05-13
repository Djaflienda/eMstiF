//
//  CardsPresenter.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 04/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

protocol CardsPresentationLogic {
    func presentData(response: Cards.Model.Response.ResponseType)
}

class CardsPresenter: CardsPresentationLogic {
    weak var viewController: CardsDisplayLogic?
    
    func presentData(response: Cards.Model.Response.ResponseType) {
        switch response {
        case .prepareCards(let cards):
            DispatchQueue.main.async {
                let clothCards = self.createClothCards(from: cards)
                self.viewController?.displayData(viewModel: .presentCards(cards: clothCards))
            }
            
        case .prepareAlert(let error):
            DispatchQueue.main.async {
                self.viewController?.displayData(viewModel: .presentAlert(alert: error))
            }
        case .prepareNothing:
            DispatchQueue.main.async {
                self.viewController?.displayData(viewModel: .presentNothing)
            }
        }
    }
    
    private func createClothCards(from clothArray: [Cloth]) -> [ClothCard] {
        let clothCards = clothArray.map { (cloth) -> ClothCard in
            let card = ClothCard(with: cloth)
            return card
        }
        return clothCards
    }
}
