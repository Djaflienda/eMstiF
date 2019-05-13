//
//  MarkCard.swift
//  FitsMe
//
//  Created by Sergey Romanchuk on 15/03/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

extension NetworkManager{
    func markCard(clotheId: Int, asLiked: Bool, complition: @escaping (_ error: String?) -> Void) {
        router.request(.markCard(clotheId: clotheId, asLiked: asLiked)) {(data, response, error) in
            if error != nil {
                complition("Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
                complition(String(response.statusCode))
            }
        }
    }
}
