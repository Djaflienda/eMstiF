//
//  ProfileViewController.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 12/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

protocol ProfileDisplayLogic: class {
    func displayData(viewModel: ProfileScreen.Model.ViewModel.ViewModelData)
}

class ProfileViewController: UIViewController, ProfileDisplayLogic {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: ProfileBusinessLogic?
    var router: (NSObjectProtocol & ProfileRoutingLogic)?
    
    let menuItems = [[MenuItem(image: "menuSizes", label: "First"), MenuItem(image: "menuDress", label: "Second")], [MenuItem(image: "menuClock", label: "Third"), MenuItem(image: "menuRefresh", label: "Fourth")], [MenuItem(image: "menuComment", label: "Fifth")], [MenuItem(image: "menuSignOut", label: "Sign out")]]
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = ProfileInteractor()
        let presenter             = ProfilePresenter()
        let router                = ProfileRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    deinit {
        print("ProfileViewController dealloc")
    }
    
    func displayData(viewModel: ProfileScreen.Model.ViewModel.ViewModelData) {
        
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == IndexPath(row: 0, section: 3) {
            router?.routeToSignOut(segue: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 20.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .init(x: 0, y: 0, width: self.tableView.frame.width, height: 20))
        view.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        let separator = UIView(frame: .init(x: 0, y: 1, width: self.tableView.frame.width, height: 18))
        separator.backgroundColor = .white
        view.addSubview(separator)
        return view
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseId, for: indexPath) as! MenuCell
        let isLastElement = indexPath.row != menuItems[indexPath.section].count - 1
        cell.configure(with: menuItems[indexPath.section][indexPath.row], separator: isLastElement)
        return cell
    }
}
