//
//  AppDelegate.swift
//  FitsMe
//
//  Created by Тигран Хачатурян on 20/01/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let authRequestFactory = di.resolve(AuthRequestFactory.self)
        let errorHandler = di.resolve(AbstractErrorHandler.self)
        
        authRequestFactory?.singup(login: "qwerty", password: "password", completionHandler: { response in
            if let token = response.response?.token {
                print(token)
            }
            if let error = response.error {
                let customError = AppError.internalError(error.message)
                errorHandler?.handle(error: customError)
            }
        })
        
        authRequestFactory?.singin(login: "qwerty", password: "password", completionHandler: { response in
            if let token = response.response?.token {
                print(token)
            }
            if let error = response.error {
                let customError = AppError.internalError(error.message)
                errorHandler?.handle(error: customError)
            }
        })
        
        return true
    }
}
