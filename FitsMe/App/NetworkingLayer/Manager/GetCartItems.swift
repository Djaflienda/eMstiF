//
//  GetCartItems.swift
//  FitsMe
//
//  Created by Sergey Romanchuk on 30/03/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

extension NetworkManager {
    func getCartItems(page: Int, status: String, complition: @escaping (_ data: [CartItem]?, _ error: String?) -> Void) {
        router.request(.getCartItems(page: page, status: status)) { (data, response, error) in
            if error != nil {
                complition(nil, "Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                guard let responseData = data else {
                    complition(nil, NetworkResponse.noData.rawValue)
                    return
                }
                switch result {
                case .success:
                    print("Success")
                    do {
                        let apiResponse = try JSONDecoder().decode(CartData.self, from: responseData)
                        guard let cartItems = apiResponse.response?.items.first?.orderitems else { return }
                        complition(cartItems, nil)
                    } catch {
                        print("Something goes wrong")
                        complition(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(_):
                    print("Fail")
                    do {
                        let apiErrorResponse = try JSONDecoder().decode(CartData.self, from: responseData)
                        guard let code = apiErrorResponse.error?.code else {
                            return
                        }
                        complition(nil, self.handleNetworkSpecificErrors(code))
                    } catch {
                        complition(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                }
            }
        }
    }
}
