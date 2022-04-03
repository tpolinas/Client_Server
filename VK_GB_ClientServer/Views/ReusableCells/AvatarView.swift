//
//  AvatarView.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 24.12.2021.
//

import Foundation
import UIKit

class AvatarImage: UIImageView {
    @IBInspectable var borderColor: UIColor = .lightGray
    @IBInspectable var borderWidth: CGFloat = 2
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    static func animateAvatar(_  object: UIImageView) {
       
       let animation = CASpringAnimation(keyPath: "bounds.size.width")
       animation.fromValue = object.layer.bounds.size.width - 10
       animation.toValue = object.layer.bounds.size.width
       animation.mass = 1
       animation.stiffness = 250
       animation.initialVelocity = 1
       animation.duration = 1.0

       let animation1 = CASpringAnimation(keyPath: "bounds.size.height")
       animation1.fromValue = object.layer.bounds.size.height - 10
       animation1.toValue = object.layer.bounds.size.height
       animation1.mass = 1
       animation1.stiffness = 250
       animation1.initialVelocity = 1
       animation1.duration = 1.0
       
       let animationGroup = CAAnimationGroup()
       animationGroup.animations = [animation, animation1]
       object.layer.add(animationGroup, forKey: nil)
    }
}

class AvatarBackShadow: UIView {
    @IBInspectable var shadowColor: UIColor = .lightGray
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 2, height: 2)
    @IBInspectable var shadowOpacity: Float = 1
    @IBInspectable var shadowRadius: CGFloat = 5
    
    override func awakeFromNib() {
        self.backgroundColor = .clear
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
}

