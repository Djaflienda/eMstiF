//
//  getProfile.swift
//  FitsMe
//
//  Created by Sergey Romanchuk on 05/05/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func getProfile(page: Int, complition: @escaping (_ data: Profile?, _ error: String?) -> ()) {
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
                        let apiResponse = try JSONDecoder().decode(ProfileResponse.self, from: responseData)
                        
                        guard let profile = apiResponse.response else {return}
                        print(profile)
                        complition(profile, nil)
                        
                    } catch {
                        print("Something goes wrong")
                        complition(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(_):
                    print("Fail")
                    do {
                        let apiErrorResponse = try JSONDecoder().decode(ProfileResponse.self, from: responseData)
                        guard let code = apiErrorResponse.response?.street else {
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