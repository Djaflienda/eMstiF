//
//  NetworkRouter.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 08/03/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

public typealias NetworkRouterComplition = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, complition: @escaping NetworkRouterComplition)
    func cancel()
}
