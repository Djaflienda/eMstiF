//
//  FavoriteCell.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 27/02/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseId = "FavoriteCell"

    //MARK: -IBOutlets
    @IBOutlet weak var clothImage: UIImageView!
    @IBOutlet weak var brandTitleLabel: UILabel!
    @IBOutlet weak var clothTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    //MARK: -Properties
    
    var closure: ((Int) -> Void)?
    var targetId: Int?
    
    //MARK: -Init
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.addToCartButton.addTarget(self, action: #selector(moveToCart), for: .touchUpInside)
    }
    
    //MARK: -IBActions
    
    @IBAction func moveToCart(_ sender: UIButton) {
        guard let targetId = targetId else { return }
        closure?(targetId)
    }
    //MARK: -Handlers
    
//    @objc func moveToCart() {
//        //можно сделать через клоужер
//    }
    
    //remove Optional later and fill with Cloth Data
    func fillWith(data: Cloth) {
        self.targetId = data.id
        clothImage.cacheFavoriteImage(url: URL(string: data.pics[0].url)!)
        brandTitleLabel.text = data.brand
        clothTitleLabel.text = data.clothe_type.title
        priceLabel.text = "\(data.id)₽"
        print(brandTitleLabel.font)
        print(clothTitleLabel.font)
        print(priceLabel.font)
        print(addToCartButton.titleLabel?.font)


    }
    
    func configureButton(basedOn dataState: FavoriteModel) {
        switch dataState.in_cart {
        case false:
            configureToCartButton()
        case true:
            configureIsAtCartButton()
        }
    }
    
    private func configureToCartButton() {
        addToCartButton.setBackgroundImage(UIImage(named: "cartButton"), for: .normal)
        addToCartButton.setTitle("Добавить в корзину", for: .normal)
        addToCartButton.setTitleColor(.white, for: .normal)
    }
    
    private func configureIsAtCartButton() {
        addToCartButton.setBackgroundImage(UIImage(named: "inCartButton"), for: .normal)
        addToCartButton.setTitle("Товар в корзине", for: .normal)
        addToCartButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.54), for: .normal)
    }

}


let favotireCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func cacheFavoriteImage(url: URL) {
        image = nil
        
        if let imageFromCache = favotireCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            print("UPLOAD PHOTO")
            
            if let response = data {
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: response) {
                        favotireCache.setObject(imageToCache, forKey: url as AnyObject)
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
