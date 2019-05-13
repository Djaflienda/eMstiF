//
//  CartViewController.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 10/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

protocol CartDisplayLogic: class {
    func displayData(viewModel: Cart.Model.ViewModel.ViewModelData)
}

class CartViewController: UIViewController, CartDisplayLogic {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView! {
        didSet {
            bottomView.layer.shadowColor = UIColor.black.cgColor
            bottomView.layer.shadowRadius = 4.0
            bottomView.layer.shadowOffset = CGSize(width: 0, height: -2)
            bottomView.layer.shadowOpacity = 0.25
        }
    }
    
    var interactor: CartBusinessLogic?
    var router: (NSObjectProtocol & CartRoutingLogic)?
    
    var cartItems = [Cloth]()
    
    private lazy var alertView = InformationView()
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = CartInteractor()
        let presenter             = CartPresenter()
        let router                = CartRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.makeRequest(request: .getCartItems)
    }
    
    deinit {
        print("CartViewController dealloc")
    }
    
    func displayData(viewModel: Cart.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .presentCart(let cartItems):
            self.cartItems.removeAll()
            self.cartItems.append(contentsOf: cartItems)
            self.tableView.isHidden = false
            self.bottomView.isHidden = false
            self.alertView.removeFromSuperview()
            self.tableView.reloadData()
        case .presentAlert:
            self.tableView.isHidden = true
            self.bottomView.isHidden = true
            self.alertView.configureAlert(type: .noMoreCards, target: self)
        }
    }
}

