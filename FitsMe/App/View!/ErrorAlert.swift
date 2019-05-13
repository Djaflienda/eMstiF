//
//  ErrorAlert.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 04/05/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

enum AlertButtonOptions: String {
    case refresh = "Обновить"
    case notification = "Подписаться на уведомления"
    case moveToFavorite = "Перейти в избранное"
}

class InformationView: UIView {
    
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.numberOfLines = 0
        tl.textAlignment = .center
        tl.font = UIFont(name: "SFUIText-Medium", size: 18)
        tl.text = "Вы просмотрели все товары"
        return tl
    }()
    
    let actionButton: UIButton = {
        let ab = UIButton()
        ab.setBackgroundImage(UIImage(named: "cartButton"), for: .normal)
        ab.titleLabel?.font = UIFont(name: "SFUIText-Medium", size: 16)
        ab.setTitleColor(.white, for: .normal)
        ab.setTitle(AlertButtonOptions.notification.rawValue, for: .normal)
        return ab
    }()
    
    let additionalLabel: UILabel = {
        let al = UILabel()
        al.textAlignment = .center
        al.numberOfLines = 0
        al.font = UIFont.systemFont(ofSize: 12, weight: .light)
        al.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
        al.text = "Мы сообщим вам, когда появятся новинки"
        return al
    }()
    
    enum CardAlertType {
        case noMoreCards
        case error(error: String)
    }
    
    func configureAlert(type: CardAlertType, target: UIViewController) {
        switch type {
        case .noMoreCards:
            setupView(target: target)
        case .error(let error):
            self.titleLabel.text = error
            self.actionButton.setTitle(AlertButtonOptions.refresh.rawValue, for: .normal)
            self.additionalLabel.text = nil
            setupView(target: target)
        }
    }
    
    private func setupView(target: UIViewController) {
        target.view.addSubview(self)
        
        self.anchor(centerX: target.view.centerXAnchor, centerY: target.view.centerYAnchor, size: .init(width: 280, height: 128))
        
        self.addSubviews(views: [self.titleLabel, self.actionButton, self.additionalLabel])
        
        self.titleLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor)
        self.titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 21).isActive = true
        
        self.actionButton.anchor(top: self.titleLabel.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 40))
        
        self.additionalLabel.anchor(top: self.actionButton.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, padding: .init(top: 19, left: 0, bottom: 0, right: 0))
        self.additionalLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 19).isActive = true
        
        target.view.sendSubviewToBack(self)
    }
}

