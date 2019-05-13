//
//  CartInteractor.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 10/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

protocol CartBusinessLogic {
    func makeRequest(request: Cart.Model.Request.RequestType)
}

class CartInteractor: CartBusinessLogic {
    
    var presenter: CartPresentationLogic?
    var service: CartService?
    
    private var cartItems = [CartItem]()
    
    func makeRequest(request: Cart.Model.Request.RequestType) {
        if service == nil {
            service = CartService()
        }
        switch request {
        case .getCartItems:
            service?.getCartItems(complition: { (cartItems, error) in
                if let _ = error {
                    return
                }
                if let cartItems = cartItems, !cartItems.isEmpty {
                    self.cartItems.removeAll()
                    self.cartItems.append(contentsOf: cartItems)
                    self.presenter?.presentData(response: .prepareCart(items: cartItems))
                } else {
                    self.presenter?.presentData(response: .prepareAlert)
                }
            })
        case .removeItemFromCart(let index):
            let target = cartItems.remove(at: index)
            service?.removeItemFromCart(id: target.id, complition: { (result) in
                switch result {
                case .success:
                    print("CART ITEM WAS REMOVED SUCCESSFULLY")
                    if self.cartItems.isEmpty {
                        self.presenter?.presentData(response: .prepareAlert)
                    }
                case .failure(_):
                    //have to fix all error here
                    print("CART ITEM WAS NOT REMOVED")
                }
            })
        }
    }
}
