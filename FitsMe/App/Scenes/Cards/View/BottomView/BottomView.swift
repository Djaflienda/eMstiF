//
//  BottomView.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 10/05/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

class ShadowContainer: UIView {
    
    let generalView: UIView = {
        let gv = UIView()
        gv.clipsToBounds = true
        gv.backgroundColor = .white
        return gv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.5
        self.addSubview(generalView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        generalView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
        generalView.layer.cornerRadius = self.frame.width / 2
    }
}

final class CardBottomView: UIStackView {
    
    weak var delegate: ClothCardDelegate?
    
    let undoShadow = ShadowContainer()
    
    private let undoButton: UIButton = {
        let ub = UIButton()
        ub.setImage(UIImage(named: "bottomUndo"), for: .normal)
//        ub.setImage(UIImage(named: "undoButton - selected"), for: .highlighted)
//        ub.addTarget(self, action: #selector(dislikeButtonPressed), for: .touchUpInside)
        return ub
    }()
    
    let dislikeShadow = ShadowContainer()
    
    private let dislikeButton: UIButton = {
        let db = UIButton()
        db.setImage(UIImage(named: "bottomCancel"), for: .normal)
//        db.setImage(UIImage(named: "dislikeButton - selected"), for: .highlighted)
        db.addTarget(self, action: #selector(dislikeButtonPressed), for: .touchUpInside)
        return db
    }()
    
    @objc func dislikeButtonPressed() {
        delegate?.markCard(asLiked: false)
    }
    
    let likeShadow = ShadowContainer()
    
    private let likeButton: UIButton = {
        let lb = UIButton()
        lb.setImage(UIImage(named: "bottomLike"), for: .normal)
//        lb.setImage(UIImage(named: "For You Icon - selected"), for: .highlighted)
        lb.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        return lb
    }()
    
    @objc func likeButtonPressed() {
        delegate?.markCard(asLiked: true)
    }
    
    let filterShadow = ShadowContainer()
    
    private let filterButton: UIButton = {
        let fb = UIButton()
        fb.setImage(UIImage(named: "bottomFilter"), for: .normal)
//        fb.setImage(UIImage(named: "filterButton"), for: .highlighted)
//        fb.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        return fb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.alignment = .center
        self.addArrangedSubviews(views: [undoShadow, dislikeShadow, likeShadow, filterShadow])
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupBottomView(target: UIViewController) {
        
        target.view.addSubview(self)
        
        self.anchor(leading: target.view.leadingAnchor, trailing: target.view.trailingAnchor, bottom: target.view.bottomAnchor, padding: .init(top: 0, left: 28, bottom: 14, right: 28), size: .init(width: 0, height: 56))
        
        undoShadow.anchor(size: .init(width: 40, height: 40))
        undoShadow.addSubview(undoButton)
        undoButton.fillSuperview()
        
        dislikeShadow.anchor(size: .init(width: 56, height: 56))
        dislikeShadow.addSubview(dislikeButton)
        dislikeButton.fillSuperview()
        
        likeShadow.anchor(size: .init(width: 56, height: 56))
        likeShadow.addSubview(likeButton)
        likeButton.fillSuperview()
        
        filterShadow.anchor(size: .init(width: 40, height: 40))
        filterShadow.addSubview(filterButton)
        filterButton.fillSuperview()
    }
}
