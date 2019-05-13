//
//  ProfileInteractor.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 12/05/2019.
//  Copyright (c) 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

protocol ProfileBusinessLogic {
  func makeRequest(request: ProfileScreen.Model.Request.RequestType)
}

class ProfileInteractor: ProfileBusinessLogic {

  var presenter: ProfilePresentationLogic?
  var service: ProfileService?
  
  func makeRequest(request: ProfileScreen.Model.Request.RequestType) {
    if service == nil {
      service = ProfileService()
    }
  }
  
}
