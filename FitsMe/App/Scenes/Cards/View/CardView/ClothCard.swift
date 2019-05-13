//
//  ClothCard.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 03/03/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

final class ClothCard: SwipableCard {
    
    private var isExpanded: Bool = false
    private var height: (expended: CGFloat, collapsed: CGFloat) = (150, 66)
        
    private let descriptionView: UIView = {
        let dv = UIView()
        dv.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
        dv.layer.cornerRadius = 10
        dv.clipsToBounds = true
        return dv
    }()
    
    private let shadowContainer: UIView = {
        let sc = UIView()
        sc.layer.backgroundColor = UIColor.clear.cgColor
        sc.layer.shadowColor = UIColor.black.cgColor
        sc.layer.shadowRadius = 4.0
        sc.layer.shadowOffset = CGSize(width: 0, height: -2)
        sc.layer.shadowOpacity = 0.25
        return sc
    }()
    
    private let storeLabel: UILabel = {
        let sl = UILabel()
        sl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return sl
    }()
    
    private let clothLabel: UILabel = {
        let cl = UILabel()
        cl.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return cl
    }()
    
    private let infoButton: UIButton = {
        let ib = UIButton()
        ib.setImage(UIImage(named: "expandButton"), for: .normal)
        ib.addTarget(self, action: #selector(infoButtonPressed), for: .touchUpInside)
        return ib
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        print("I was CREATED")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(with data: Cloth) {
        self.init(frame: .zero)
        configureClothCard(with: data)
    }
    
    deinit {
        print("I was DELETED")
    }
    
    func setupClothCard(target: UIViewController) {
        target.view.addSubview(self)
        self.anchor(centerX: target.view.centerXAnchor, top: target.view.safeAreaLayoutGuide.topAnchor, leading: target.view.leadingAnchor, trailing: target.view.trailingAnchor, bottom: target.view.bottomAnchor, padding: .init(top: 14, left: 14, bottom: 84, right: 14))
        
        self.addSubview(shadowContainer)
        shadowContainer.anchor(leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, padding: .init(top: 0, left: 7, bottom: 7, right: 7), size: .init(width: 0, height: 66))
        
        shadowContainer.addSubview(descriptionView)
        descriptionView.anchor(top: shadowContainer.topAnchor, leading: shadowContainer.leadingAnchor, trailing: shadowContainer.trailingAnchor, bottom: shadowContainer.bottomAnchor)
        
        descriptionView.addSubviews(views: [infoButton, storeLabel, clothLabel])
        infoButton.anchor(top: descriptionView.topAnchor, trailing: descriptionView.trailingAnchor, padding: .init(top: 21, left: 0, bottom: 0, right: 16), size: .init(width: 24, height: 24))
        storeLabel.anchor(top: descriptionView.topAnchor, leading: descriptionView.leadingAnchor, trailing: infoButton.leadingAnchor, padding: .init(top: 14, left: 14, bottom: 0, right: 14), size: .init(width: 0, height: 14))
        clothLabel.anchor(top: storeLabel.bottomAnchor, leading: descriptionView.leadingAnchor, trailing: descriptionView.trailingAnchor, padding: .init(top: 10, left: 14, bottom: 0, right: 14), size: .init(width: 0, height: 14))
        
        target.view.sendSubviewToBack(self)
    }
    
    private func configureClothCard(with data: Cloth) {
        isUserInteractionEnabled = true
        contentMode = .scaleAspectFill
        storeLabel.text = data.brand
        clothLabel.text = "\(data.id)"
        cacheImage(url: URL(string: data.pics[0].url)!)
    }
    
    func setGestureRecognizer() {
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleCardPan)))
    }
    
    @objc private func infoButtonPressed() {
        isExpanded.toggle()
        UIView.animate(withDuration: 0.3, animations: {
            if let constraint = (self.shadowContainer.constraints.filter{$0.firstAttribute == .height}.first) {
                constraint.constant = self.isExpanded ? self.height.expended : self.height.collapsed
            }
            self.layoutIfNeeded()
            self.infoButton.transform = CGAffineTransform(rotationAngle: self.isExpanded ? 3.1416 : 0)
        })
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {

    func cacheImage(url: URL) {
        image = nil

        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: url) {
            data, response, error in
            print("UPLOAD PHOTO")
            if let response = data {
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: response) {
                        imageCache.setObject(imageToCache, forKey: url as AnyObject)
                        self.image = imageToCache
                    } else {
                        print("no image found - CACHE FILE")
                        self.image = UIImage(named: "dummy_image")
                    }
                }
            }
        }.resume()
    }
}
