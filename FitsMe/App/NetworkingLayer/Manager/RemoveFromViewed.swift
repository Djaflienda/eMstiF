//
//  RemoveFromViewed.swift
//  FitsMe
//
//  Created by Sergey Romanchuk on 08/04/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

extension NetworkManager{
    func removeFromViewed(id: Int, method: HTTPMethod, complition: @escaping (_ message: NetworkManager.Result<String>) -> Void) {
        router.request(.removeFromViewed(id: id, method: method)) {(_, response, error) in
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
