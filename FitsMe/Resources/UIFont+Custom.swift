//
//  UIFont+Custom.swift
//  FitsMe
//
//  Created by Тигран Хачатурян on 23/01/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

extension UIFont {
    
    class var appNameTitle: UIFont {
        return UIFont(name: "Courgette-Regular", size: 64.0)!
    }
    
    class var buttonLabel: UIFont {
        return UIFont.systemFont(ofSize: 18.0, weight: .semibold)
    }
    
    class var textField: UIFont {
        return UIFont(name: "Roboto-Regular", size: 14.0)!
    }
    
    class var warning: UIFont {
        return UIFont(name: "Roboto-Regular", size: 10.0)!
    }
    
}
