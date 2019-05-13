//
//  GetFavoriteItems.swift
//  FitsMe
//
//  Created by Denis Abramov on 17/04/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

extension NetworkManager {
    func getFavoriteItems(page: Int, complition: @escaping (_ data: [FavoriteModel]?, _ error: String?) -> Void) {
        router.request(.getFavoriteItems(page: page)) { (data, response, error) in
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
//                        print(responseData)
                        let apiResponse = try JSONDecoder().decode(FavoriteDataResponse.self, from: responseData)
                        
                        let favoriteAPIData = APIPaginationData.shared
                        favoriteAPIData.favoriteData = apiResponse.response!
                        
                        guard let favoriteArray = apiResponse.response?.items else {return}
                        var newData = [FavoriteModel]()
                        for element in favoriteArray {
                            guard let element = element else {return}
                            newData.append(element)
                        }
                        complition(newData, nil)
                    } catch {
                        print("Something goes wrong")
                        complition(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(_):
                    print("Fail")
//                    do {
//                        let apiErrorResponse = try JSONDecoder().decode(ClothesDataResponse.self, from: responseData)
//                        guard let code = apiErrorResponse.response?.detail else {
//                            return
//                        }
                        complition(nil, /*self.handleNetworkSpecificErrors(code*/nil)
//                    } catch {
//                        complition(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
                }
            }
        }
    }
}
