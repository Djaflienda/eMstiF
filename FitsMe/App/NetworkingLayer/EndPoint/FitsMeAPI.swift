//
//  FitsMeAPI.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 08/03/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case fitsMe
}

public enum FitsMeAPI {
    
    case signUp(login: String, password: String)
    case signIn(login: String, password: String)
    case markCard(clotheId: Int, asLiked: Bool)
    case getClothes(page: Int)
    case getFavoriteItems(page: Int)
    case getCartItems(page: Int, status: String)
    case removeFromViewed(id: Int, method: HTTPMethod)
    case removeFromCart(id: Int)
    case moveToCart(clothID: Int, quantity: Int)
    case clothesSize(Void)
    case putProfile(tel: String, street: String, apartment: String, top_size: String, bottom_size: String)
    case getProfile(Void)
}

extension FitsMeAPI: EndPointType {
    
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .fitsMe:
            return "https://fitsme.ru/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "customers/signup/"
        case .signIn:
            return "customers/signin/"
        case .markCard:
            return "viewed/"
        case .getClothes:
            return "clothes/"
        case .getFavoriteItems:
            return "viewed/"
        case .moveToCart:
            return "orders/items/"
        case .getCartItems:
            return "orders/"
        case .removeFromViewed(let id, _):
            return "viewed/" + String(id) + "/"
        case .removeFromCart(let id):
            return "orders/items/" + String(id) + "/"
        case .clothesSize:
            return "clothes/sizes/"
        case .putProfile:
            return "profile/"
        case .getProfile:
            return "profile/"
        
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signUp:
            return .post
        case .signIn:
            return .post
        case .markCard:
            return .post
        case .getClothes:
            return .get
        case .getFavoriteItems:
            return .get
        case .getCartItems:
            return .get
        case .removeFromViewed(_, let method):
            return method
        case .removeFromCart:
            return .delete
        case .moveToCart:
            return .post
        case .clothesSize:
            return .get
        case .putProfile:
            return .put
        case .getProfile:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .signUp(let login, let password):
            return .requestParameters(bodyParameters: ["login": login,
                                                       "password": password],
                                      urlParameters: nil)
            
        case .signIn(let login, let password):
            return .requestParameters(bodyParameters: ["login": login,
                                                       "password": password],
                                      urlParameters: nil)
            
        case .markCard(let clothes_id, let asLiked):
            return .requestParametersAndHeaders(bodyParameters: ["clothe_id": clothes_id,
                                                                 "liked": asLiked],
                                                urlParameters: nil,
                                                aditionalHeaders: headers)
            
        case .getClothes(let page):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: ["page": page],
                                                aditionalHeaders: headers)
        
        case .getFavoriteItems(let page):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: ["page": page],
                                                aditionalHeaders: headers)
            
        case .getCartItems(let page, let status):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: ["page": page, "status": status],
                                                aditionalHeaders: headers)
        
        case .removeFromCart(_):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: nil,
                                                aditionalHeaders: headers)
            
        case .moveToCart(let clothID, let quantity):
            return .requestParametersAndHeaders(bodyParameters: ["cloth_id": clothID, "quantity": quantity],
                                                urlParameters: nil,
                                                aditionalHeaders: headers)
            
        case .removeFromViewed(let id):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: ["id": id],
                                                aditionalHeaders: headers)
            
        case .clothesSize():
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: nil,
                                                aditionalHeaders: headers)
        
        case .putProfile(let tel, let street, let apartment, let top_size, let bottom_size):
            return .requestParametersAndHeaders(bodyParameters: ["tel": tel,
                                                                 "street": street,
                                                                 "apartment": apartment,
                                                                 "top_size": top_size,
                                                                 "bottom_size": bottom_size],
                                                urlParameters: nil,
                                                aditionalHeaders: headers)
        
        case .getProfile():
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: nil,
                                                aditionalHeaders: headers)
        }
    }
    
    var headers: HTTPHeaders? {
        guard let token = TokenSave.get_token() else { return nil }
        return ["Authorization": "token \(token)"]
    }
}
