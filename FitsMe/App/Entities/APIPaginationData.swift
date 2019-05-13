//
//  APIPaginationData.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 18/04/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

/*
Class helps to store information from API about current/next pages
 to load information separately
We store last response information inside one of class properties
 and ask for next page to fetch next portion of information
*/

class APIPaginationData {
    
    static let shared = APIPaginationData()
    
    private init() {}
    
    var favoriteData = FavoriteResponse()
    var cardsData = ClothesResponse()
    //add cartData here too
}
