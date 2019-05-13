//
//  UIViewExtension.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 18/02/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    //MARK: -Propertries
    
    lazy var shadowView: UIView = {
        let sv = UIView()
        sv.backgroundColor = .white
        sv.alpha = 0.95
        sv.layer.cornerRadius = 38
        return sv
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        ai.color = .redWine
        return ai
    }()

    //MARK: -Init

    //MARK: -Handlers

    func showActivityIndicator() {

        self.addSubview(shadowView)
        shadowView.addSubview(activityIndicator)

        shadowView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            shadowView.topAnchor.constraint(equalTo: self.topAnchor),
            shadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: shadowView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: shadowView.centerYAnchor)
            ])

        activityIndicator.startAnimating()
    }

    func removeActivityIndicator() {

            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            shadowView.removeFromSuperview()
    }
}

