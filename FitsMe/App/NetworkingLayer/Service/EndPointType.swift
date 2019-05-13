//
//  EndPointType.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 08/03/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

protocol EndPointType {
    
    var baseURL: URL { get }
    
    var path: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    var task: HTTPTask { get }
    
    var headers: HTTPHeaders? { get }
    
}
