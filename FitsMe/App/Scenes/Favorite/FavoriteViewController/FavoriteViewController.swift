//
//  FavoriteViewController.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 10/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

protocol FavoriteDisplayLogic: class {
    func displayData(viewModel: Favorite.Model.ViewModel.ViewModelData)
}

class FavoriteViewController: UIViewController, FavoriteDisplayLogic {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: FavoriteBusinessLogic?
    var router: (NSObjectProtocol & FavoriteRoutingLogic)?
    
    var favoriteItems = [Cloth]()
    
    private lazy var alertView = InformationView()
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = FavoriteInteractor()
        let presenter             = FavoritePresenter()
        let router                = FavoriteRouter()
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
        
        //remove it later
        let button = UIButton()
        button.frame = .init(x: 200, y: 100, width: 200, height: 50)
        button.setTitle("Do not touch - for debug", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(removeAll), for: .touchUpInside)
        view.addSubview(button)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.makeRequest(request: .getFavoriteItems)
    }
    
    deinit {
        print("FavoriteViewController dealloc")
    }
    
    
    //for debug
    @objc func removeAll() {
        let network = NetworkManager()
        let index = interactor?.favoriteItems.first?.id
        (index!-100...index!).forEach { (id) in
            network.removeFromViewed(id: id, method: .delete, complition: { (result) in
                switch result {
                case .success:
                    print("FAV DEL SUCCESSFULL")
                case .failure(_/*let error*/):
                    print("FAV DEL FAILURE")
                }
            })
        }
        
    }
    
    func displayData(viewModel: Favorite.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .presentFavorite(let items):
            self.favoriteItems.removeAll()
            self.favoriteItems.append(contentsOf: items)
            self.tableView.isHidden = false
            self.alertView.removeFromSuperview()
            self.tableView.reloadData()
        case .presentAlert:
            self.tableView.isHidden = true
            self.alertView.configureAlert(type: .noMoreCards, target: self)
        }
    }
    
}
