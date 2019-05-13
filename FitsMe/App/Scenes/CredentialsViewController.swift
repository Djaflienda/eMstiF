//
//  SignUpViewController.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 17/02/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

class CredentialsViewController: UIViewController {

    //MARK: - IBOutlet
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var credentialsView: CustomView!
    @IBOutlet weak var loginErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var loginLabel: UITextField!
    @IBOutlet weak var passwordLabel: PasswordTextField!
    
    //MARK: - Properties
    
    var isRegistered: Bool!
    
    lazy var networkManager = NetworkManager()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        passwordLabel.delegate = self
//        loginLabel.delegate = self
//        passwordLabel.clearsOnBeginEditing = false
        
        scrollView.isScrollEnabled = false
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        hideKeyboardGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(hideKeyboardGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setInitialView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        print("CredentialsViewController dealloc")
    }

    //MARK: - IBAction

    @IBAction func credentialsAction(_ sender: /*CredentialsButton*/UIButton) {
        
        guard let login = loginLabel.text, let password = passwordLabel.text else {return}
        
        let loginWarningMessage  = sender.checkLogin(login)
        let passwordWarningMessage = sender.checkPassword(password)
        
        if loginWarningMessage != nil {
            //force unwrap because we have already checked for nil above
            showAlert(label: loginErrorLabel, message: loginWarningMessage!)
            return
        }
        
        if passwordWarningMessage != nil {
            //force unwrap because we have already checked for nil above
            showAlert(label: passwordErrorLabel, message: passwordWarningMessage!)
            return
        }
        
        credentialsView.showActivityIndicator()
        
        switch isRegistered {
        case true:
            networkManager.signIn(login: login, password: password) { (error) in
                
                DispatchQueue.main.async {
                    self.credentialsView.removeActivityIndicator()
                }
                
                if let error = error {
                    DispatchQueue.main.async {
//                        self.showAlertWith(error: error)
                        self.showAlert(label: self.passwordErrorLabel, message: error)

                    }
                    return
                }
                self.performNextScreen()
            }
        case false:
            networkManager.signUp(login: login, password: password) { (error) in
                
                DispatchQueue.main.async {
                    self.credentialsView.removeActivityIndicator()
                }
                
                //if there is no error and we got token - show next screen
                if let error = error {
                    DispatchQueue.main.async {
//                        self.showAlertWith(error: error)
                        self.showAlert(label: self.loginErrorLabel, message: error)
                    }
                    print(error)
                    return
                }
                self.performNextScreen()
            }
        default:break
        }
    }
    
    //MARK: - Handlers
    
    private func showAlertWith(error: String) {
        let alert = UIAlertController(title: "Authentication issues", message: "\(error)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func performNextScreen() {
        UserDefaults().set(true, forKey: "isAuthorized")
        DispatchQueue.main.async {
            let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    private func showAlert(label: UILabel, message: String) {
        label.text = message
        label.alpha = 1.0
        UIView.animate(withDuration: 0.3, delay: 3.0, options: [], animations: {
            label.alpha = 0.0
        }, completion: nil)
    }
    
    private func configureActionButton() {
        isRegistered ? signUpButton.setupButton(for: .signIn)
                        : signUpButton.setupButton(for: .signUp)
    }
    
    @objc private func performPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear

        let backButton = UIButton()
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.addTarget(self, action: #selector(performPreviousScreen), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    private func setInitialView() {
        configureNavigationBar()
        configureActionButton()
        
        loginLabel.setBottomBorder(withColor: .black)
        passwordLabel.setBottomBorder(withColor: .black)
        
        credentialsView.layer.cornerRadius = 38
    }
    
    @objc private func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        // swiftlint:disable force_cast
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        // swiftlint:enable force_cast
        let contentInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: kbSize.height / 3, right: 0.0)
        
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
        
        let bottomOffset = CGPoint(x: 0, y: 100)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
        
        scrollView.bounds = CGRect(x: 0.0, y: 0.0, width: scrollView.bounds.width, height: scrollView.bounds.height)
    }
    
    @objc private func hideKeyboard() {
        scrollView.endEditing(true)
        
        scrollView.bounds = CGRect(x: 0.0, y: 0.0, width: scrollView.bounds.width, height: scrollView.bounds.height)
    }
    
}

extension CredentialsViewController: UITextFieldDelegate {
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        return true
//    }
    
//    override func resignFirstResponder() -> Bool {
//        <#code#>
//    }
}

class PasswordTextField: UITextField {
    
    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        
        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
        return success
    }
    
}
