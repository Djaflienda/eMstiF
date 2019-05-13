//
//  OrderViewController.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 15/04/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField: CustomTextField!
    @IBOutlet weak var cityTextField: CustomTextField!
    @IBOutlet weak var streetTextField: CustomTextField!
    @IBOutlet weak var buildingTextField: CustomTextField!
    @IBOutlet weak var apartmentTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = false
        title = "Оформление заказа"
    }

}
