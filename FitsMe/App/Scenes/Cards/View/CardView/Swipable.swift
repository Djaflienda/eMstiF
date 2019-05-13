//
//  Swipable.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 19/04/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import UIKit

protocol ClothCardDelegate: class {
    func markCard(asLiked: Bool)
}

class SwipableCard: UIImageView {
    
    //MARK: -Properties
    
    weak var delegate: ClothCardDelegate!
    
    //MARK: -Handlers
    
    @objc func handleCardPan(sender: UIPanGestureRecognizer) {
        
        guard let superView = superview else { return }
        
        let translation = sender.translation(in: superView)
        let divisor = (superView.frame.width / 2) / 0.2
        let rotationAngle: CGFloat = translation.x / divisor
        switch sender.state {
        case .changed:
            self.transform = CGAffineTransform(rotationAngle: rotationAngle).concatenating(.init(translationX: translation.x, y: .zero))
        case .ended:
            if abs(translation.x) < superView.frame.width * 0.3 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: [], animations: {
                    self.transform = .identity
                }, completion: nil)
                return
            }
            if translation.x <= -superView.frame.width * 0.3 {
                delegate?.markCard(asLiked: false)
            } else if translation.x >= superView.frame.width * 0.3 {
                delegate.markCard(asLiked: true)
            }
            self.removeFromSuperview()
        default: break
        }
    }
}
