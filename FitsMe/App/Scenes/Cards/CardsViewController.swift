//
//  CardsViewController.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 04/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

protocol CardsDisplayLogic: class {
    func displayData(viewModel: Cards.Model.ViewModel.ViewModelData)
}

class CardsViewController: UIViewController, CardsDisplayLogic {
    
    var interactor: CardsBusinessLogic?
    var router: (NSObjectProtocol & CardsRoutingLogic)?
    
    private var cardsArray = [ClothCard]() {
        didSet {
            guard let card = self.cardsArray.first else { return }
            card.setGestureRecognizer()
            self.view.bringSubviewToFront(card)
        }
    }
    private lazy var alertView = InformationView()
    private lazy var bottomView = CardBottomView()
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = CardsInteractor()
        let presenter             = CardsPresenter()
        let router                = CardsRouter()
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
        interactor?.makeRequest(request: .getCards)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    deinit {
        print("CardsViewController dealloc")
    }
    
    func displayData(viewModel: Cards.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .presentCards(let cards):
            cards.forEach { (card) in
                card.setupClothCard(target: self)
                card.delegate = self
            }
            self.bottomView.setupBottomView(target: self)
            bottomView.delegate = self
            self.cardsArray.append(contentsOf: cards)
            
        case .presentAlert(let alert):
            alert != nil ? alertView.configureAlert(type: .error(error: alert!), target: self) :
                alertView.configureAlert(type: .noMoreCards, target: self)
            
        case .presentNothing:
            if cardsArray.isEmpty { bottomView.removeFromSuperview() }
            if cardsArray.count <= 1 {
                APIPaginationData.shared.cardsData.next != nil ?
                    interactor?.makeRequest(request: .getCards) :
                    alertView.configureAlert(type: .noMoreCards, target: self)
            }
        }
    }
    
    @objc private func likeButtonPressed() {
        markCard(asLiked: true)
    }
}

extension CardsViewController: ClothCardDelegate {
    func markCard(asLiked: Bool) {
        cardsArray.first?.removeFromSuperview()
        cardsArray.remove(at: 0)
        interactor?.makeRequest(request: .markCard(asLiked: asLiked))
    }
}
