//
//  ProfilePresenter.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 12/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

protocol ProfilePresentationLogic {
  func presentData(response: ProfileScreen.Model.Response.ResponseType)
}

class ProfilePresenter: ProfilePresentationLogic {
  weak var viewController: ProfileDisplayLogic?
  
  func presentData(response: ProfileScreen.Model.Response.ResponseType) {
  
  }
  
}
