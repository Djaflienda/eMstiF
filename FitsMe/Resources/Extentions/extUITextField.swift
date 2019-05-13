//
//  extUITextField.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 23/03/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setBottomBorder(withColor color: UIColor) {
        self.borderStyle = UITextField.BorderStyle.none
        self.backgroundColor = UIColor.clear
        let width: CGFloat = 1.0
        
        let borderLine = UIView(frame: CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width))
        borderLine.backgroundColor = color
        self.addSubview(borderLine)
    }
}

class CustomTextField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderStyle = UITextField.BorderStyle.none
        backgroundColor = UIColor.clear
        let width: CGFloat = 1.0
        
        let borderLine = UIView(frame: CGRect(x: 0, y: frame.height - width, width: frame.width, height: width))
        borderLine.backgroundColor = UIColor(red: 0.74, green: 0.73, blue: 0.76, alpha: 1.0)
        addSubview(borderLine)
    }
    
}
