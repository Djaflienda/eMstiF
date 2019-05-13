//
//  SignUp.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 09/03/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func signUp(login: String, password: String, complition: @escaping (_ error: String?) -> Void) {
        router.request(.signUp(login: login, password: password.sha256())) { (data, response, error) in
            if error != nil {
                complition("Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                print(response)
                let result = self.handleNetworkResponse(response)
                guard let responseData = data else {
                    complition(NetworkResponse.noData.rawValue)
                    return
                }
                switch result {
                case .success:
                    do {
                        let apiResponse = try JSONDecoder().decode(TokenResponse.self, from: responseData)
                        TokenSave.save_token(token: apiResponse.response!.token)
                        complition(nil)
                    } catch {
                        complition(NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(_):
                    do {
                        let apiErrorResponse = try JSONDecoder().decode(TokenResponse.self, from: responseData)
                        guard let code = apiErrorResponse.error?.code else {
                            return
                        }
                        complition(self.handleNetworkSpecificErrors(code))
                    } catch {
                        complition(NetworkResponse.unableToDecode.rawValue)
                    }
                }
            }
        }
    }
}
