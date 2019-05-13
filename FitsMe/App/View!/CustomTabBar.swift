//
//  extUITabBar.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 12/04/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

//extension UITabBar {
//    override open func sizeThatFits(_ size: CGSize) -> CGSize {
//        var sizeThatFits = super.sizeThatFits(size)
//        sizeThatFits.height = 44 + (superview?.safeAreaInsets.bottom)!
//        return sizeThatFits
//    }
//}

class CustomTabBar : UITabBar {
    
    @IBInspectable var height: CGFloat = 44.0
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            
            if #available(iOS 11.0, *) {
                sizeThatFits.height = height + window.safeAreaInsets.bottom
            } else {
                sizeThatFits.height = height
            }
        }
        return sizeThatFits
    }
}
