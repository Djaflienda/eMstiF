//
//  MenuCell.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 12/05/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

struct MenuItem {
    let image: String
    let label: String
}

class MenuCell: UITableViewCell {
    
    static let reuseId = "MenuCell"
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var separator: UIView!
    
    func configure(with data: MenuItem, separator: Bool) {
        self.icon.image = UIImage(named: data.image)
        self.icon.contentMode = .scaleAspectFit
        self.label.text = data.label
        self.separator.backgroundColor = separator ? UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1) : UIColor.clear
    }
}
