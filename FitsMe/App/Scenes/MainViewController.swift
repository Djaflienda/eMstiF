//
//  MainViewController.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 17/02/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - IBOutlet
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    //MARK: - Properties
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = TokenSave.get_token() {
            let destinationVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setInitialView()
    }
    
    deinit {
        print("MainViewController dealloc")
    }
    
    //MARK: - IBAction
    
    @IBAction func performTransition(_ sender: /*CredentialsButton*/ UIButton) {
        
        sender.showCredentialsScreen(sender, navigation: navigationController)
    }
    
    //MARK: - Handlers
    
    private func setInitialView() {
        
        navigationController?.isNavigationBarHidden = true
        signInButton.setupButton(for: .signIn)
        signUpButton.setupButton(for: .signUp)
    }
}
