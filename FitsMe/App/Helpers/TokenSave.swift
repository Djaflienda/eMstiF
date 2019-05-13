//
//  TokenSave.swift
//  FitsMe
//
//  Created by Sergey Romanchuk on 09/03/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation
import Strongbox

class TokenSave{
    static let service = "FitsMeToken"
    static let sb = Strongbox()
    
    static func save_token(token:String) {
        _ = TokenSave.sb.archive(token, key: TokenSave.service)
        print("IM SAVE TOKEN")
    }
    
    static func get_token() -> String? {
        if let token = TokenSave.sb.unarchive(objectForKey: TokenSave.service) as? String {
            print("get token done")
            return token
        }
        return nil
    }
    
    static func del_token(){
        TokenSave.sb.remove(key: TokenSave.service)
        print("removed")
    }
}
