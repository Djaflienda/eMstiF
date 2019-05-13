//
//  NetworkiManager.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 08/03/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation
import CryptoSwift

enum NetworkResponse: String {
    case success
    case authenticationError = "Authentication issues."
    case notUniqueUser = "Логин занят, попробуйте другой"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case noConnection = "Please check your network connection."
}

enum NetworkSpecificErrorsMessage: String {
    case wrongLoginOrPassword = "Неправильный логин или пароль"
    case wrongLogin = "Wrong login"
    case wrongPassword = "Wrong password"
    case authCredentialsNotProvided = "Authentication credentials were not provided"
    
}

struct NetworkManager {
    
    static let environment: NetworkEnvironment = .fitsMe
    let router = Router<FitsMeAPI>()
    
    
    
    enum Result<String> {
        case success
        case failure(String)
    }
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 400:
            return .failure(NetworkResponse.notUniqueUser.rawValue)
        case 403:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func handleNetworkSpecificErrors(_ code: Int) -> String {
        switch code {
        case 100002:
            return NetworkResponse.notUniqueUser.rawValue
        case 100001:
            return NetworkSpecificErrorsMessage.wrongLoginOrPassword.rawValue
        case 100003:
            return NetworkSpecificErrorsMessage.wrongLogin.rawValue
        case 100004:
            return NetworkSpecificErrorsMessage.wrongPassword.rawValue
        case 100005:
            return NetworkSpecificErrorsMessage.authCredentialsNotProvided.rawValue
        default:
            return NetworkResponse.authenticationError.rawValue
        }
    }
    
}


