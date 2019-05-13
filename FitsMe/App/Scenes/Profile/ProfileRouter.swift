//
//  ProfileRouter.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 12/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

protocol ProfileRoutingLogic {
    func routeToSignOut(segue: UIStoryboardSegue?)
}

class ProfileRouter: NSObject, ProfileRoutingLogic {
    
    weak var viewController: ProfileViewController?
    
    // MARK: Routing
    
    func routeToSignOut(segue: UIStoryboardSegue?) {
        if let _ = segue {
            //fill this  space if use segues
        } else {
            TokenSave.del_token()
            viewController?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
