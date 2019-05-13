//
//  extUIViewCOntroller.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 12/04/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertWhenNetworkingIssuesOccur(with message: String) {
        let alert = UIAlertController(title: "Something goes wrong...", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
