//
//  extUIViewLayout.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 05/05/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

extension UIView {
    func anchor(centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func fillSuperview() {
        guard let superView = superview else { return }
        self.anchor(top: superView.topAnchor, leading: superView.leadingAnchor, trailing: superView.trailingAnchor, bottom: superView.bottomAnchor)
    }
}

extension UIStackView {
    func addArrangedSubviews(views: [UIView]) {
        views.forEach {addArrangedSubview($0)}
    }
}

extension UIView {
    func addSubviews(views: [UIView]) {
        views.forEach {addSubview($0)}
    }
}
