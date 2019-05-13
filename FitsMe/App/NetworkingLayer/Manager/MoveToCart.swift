//
//  MoveToCart.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 11/04/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func moveToCart(clothID: Int, quantity: Int, complition: @escaping (_ error: NetworkManager.Result<String>) -> Void) {
        router.request(.moveToCart(clothID: clothID, quantity: quantity)) { (_, response, error) in
            if error != nil {
                complition(.failure(NetworkResponse.noConnection.rawValue))
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                complition(result)
            }
        }
    }
}
