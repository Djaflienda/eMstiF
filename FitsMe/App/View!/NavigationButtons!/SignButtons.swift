//
//  SignButtons.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 17/02/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

enum CredentialsButtonType: String {
    case signUp = "Регистрация"
    case signIn = "Войти"
}

extension UIButton: CredentialsCheckerProtocol {
        
    func setupButton(for type: CredentialsButtonType) {
        self.layer.cornerRadius = 8
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.buttonLabel
        switch type {
        case .signIn:
            self.setTitle(CredentialsButtonType.signIn.rawValue, for: .normal)
        case .signUp:
            self.setTitle(CredentialsButtonType.signUp.rawValue, for: .normal)
        }
    }
    
    func showCredentialsScreen(_ sender: UIButton, navigation: UINavigationController?) {
        let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CredentialsViewController") as! CredentialsViewController
        switch sender.titleLabel?.text {
        case CredentialsButtonType.signUp.rawValue:
            destinationViewController.isRegistered = false
        case CredentialsButtonType.signIn.rawValue:
            destinationViewController.isRegistered = true
        default:break
        }
        navigation?.pushViewController(destinationViewController, animated: true)
    }
    
    func showLikeButton(target: UIViewController) {
        target.view.addSubview(self)
        
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: target.view.centerXAnchor),
            self.bottomAnchor.constraint(equalTo: target.view.bottomAnchor, constant: -25),
            self.widthAnchor.constraint(equalToConstant: 42.34),
            self.heightAnchor.constraint(equalToConstant: 38.55)
            ])
    }
}
