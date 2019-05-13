//
//  CartCell.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 23/03/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {
    
    static let reuseId = "CartCell"

    //MARK: -IBOutlets
    @IBOutlet weak var clothImage: UIImageView!
    @IBOutlet weak var brandTitleLabel: UILabel!
    @IBOutlet weak var clothTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    //MARK: -Properties
    
    //MARK: -Init
    
    //MARK: -IBActions
    
    //MARK: -Handlers
    
    func fillWith(data: Cloth) {
        clothImage.cacheFavoriteImage(url: URL(string: data.pics[0].url)!)
        brandTitleLabel.text = data.brand
        clothTitleLabel.text = data.name
        priceLabel.text = "\(data.id)₽"
    }

}

let cartCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func cacheCartImage(url: URL) {
        image = nil
        
        if let imageFromCache = cartCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            print("UPLOAD PHOTO")
            
            if let response = data {
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: response) {
                        cartCache.setObject(imageToCache, forKey: url as AnyObject)
                        self.image = imageToCache
                    } else {
                        print("no image found - CACHE FILE")
                        self.image = UIImage(named: "noImage")
                    }
                }
            }
            }.resume()
    }
}
