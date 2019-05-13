//
//  RemoveFromCart.rswift
//  FitsMe
//
//  Created by Sergey Romanchuk on 09/04/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation
extension NetworkManager{
    func  removeFromCart(id: Int, complition: @escaping (_ error: NetworkManager.Result<String>) -> Void) {
        router.request(.removeFromCart(id: id)) {(_, response, error) in
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
