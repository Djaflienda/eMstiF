//
//  CartPresenter.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 10/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

protocol CartPresentationLogic {
    func presentData(response: Cart.Model.Response.ResponseType)
}

class CartPresenter: CartPresentationLogic {
    weak var viewController: CartDisplayLogic?
    
    func presentData(response: Cart.Model.Response.ResponseType) {
        switch response {
        case .prepareCart(let items):
            let clothArray = items.map({ (item) -> Cloth in
                return item.clothe
            })
            DispatchQueue.main.async {
                self.viewController?.displayData(viewModel: .presentCart(items: clothArray))
            }
        case .prepareAlert:
            DispatchQueue.main.async {
                self.viewController?.displayData(viewModel: .presentAlert)
            }
        }
    }
}
