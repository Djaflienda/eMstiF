//
//   PostProfile.swift
//  FitsMe
//
//  Created by Sergey Romanchuk on 27/04/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func putProfile(tel:String, street:String, apartment:String, top_size:String, bottom_size:String, complition: @escaping (_ error: String?) -> ()) {
        router.request(.putProfile(tel:tel, street:street, apartment:apartment, top_size:top_size, bottom_size:bottom_size)) { (data, response, error) in
            if error != nil {
                complition("Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                print(response)
                print(response.statusCode)
                
            }
        }
    }
}

