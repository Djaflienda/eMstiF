//
//  GetClothes.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 17/03/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func getClothes(page: Int, complition: @escaping (_ data: [Cloth]?, _ error: String?) -> Void) {
        router.request(.getClothes(page: page)) { (data, response, error) in
            if error != nil {
                complition(nil, NetworkResponse.noConnection.rawValue)
            }
            if let response = response as? HTTPURLResponse {
//                print(response)
                let result = self.handleNetworkResponse(response)
                guard let responseData = data else {
                    complition(nil, NetworkResponse.noData.rawValue)
                    return
                }
                switch result {
                case .success:
                    print("Success")
                    do {
                        let apiResponse = try JSONDecoder().decode(ClothesDataResponse.self, from: responseData)

                        guard let clothArray = apiResponse.response?.items else {return}
                        APIPaginationData.shared.cardsData = apiResponse.response!
                        complition(clothArray, nil)
                    } catch {
                        print("Something goes wrong")
                        complition(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(_):
                    print("Fail")
                    do {
                        let apiErrorResponse = try JSONDecoder().decode(ClothesDataResponse.self, from: responseData)
                        guard let code = apiErrorResponse.response?.detail else {
                            return
                        }
                        complition(nil, /*self.handleNetworkSpecificErrors(*/code)
                    } catch {
                        complition(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                }
            }
        }
    }
}
