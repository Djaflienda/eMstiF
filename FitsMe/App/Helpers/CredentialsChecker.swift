//
//  CredentialsChecker.swift
//  FitsMe
//
//  Created by Тигран Хачатурян on 24/01/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

enum CheckerWarningsMessages: String {
    case emptyLogin = "Пожалуйста, введите логин"
    case wrongLoginLength = "Логин должен содержать от 3 до 19 символов"
    case emptyPassword = "Пожалуйста, введите пароль"
    case wrongPasswordLength = "Пароль должен содержать не менее 6 символов"
}

protocol CredentialsCheckerProtocol {
    
    func checkLogin(_ login: String) -> String?
    
    func checkPassword(_ password: String) -> String?
}

extension CredentialsCheckerProtocol {
    
    func checkLogin(_ login: String) -> String? {
        
        if login.isEmpty {
            return CheckerWarningsMessages.emptyLogin.rawValue
        }
        if login.count < 3  || login.count > 19 {
            return CheckerWarningsMessages.wrongLoginLength.rawValue
        }
        return nil
    }
    
    func checkPassword(_ password: String) -> String? {
        
        if password.isEmpty {
            return CheckerWarningsMessages.emptyPassword.rawValue
        }
        if password.count < 6 {
            return CheckerWarningsMessages.wrongPasswordLength.rawValue
        }
        return nil
    }
}
