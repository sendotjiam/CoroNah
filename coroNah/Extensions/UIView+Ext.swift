//
//  UIView+Ext.swift
//  InfoCorona
//
//  Created by Sendo Tjiam on 11/09/21.
//

import UIKit

extension UIView {
    func dropShadow(
        color: UIColor = UIColor.black,
        opacity: Float = 0.2,
        offSet: CGSize = CGSize(width: 2, height: 3),
        radius: CGFloat = 3.5,
        scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func cardShadow(color: UIColor = UIColor.black,
                    opacity: Float = 0.2,
                    offSet: CGSize,
                    radius: CGFloat = 5) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
    }
    
    func makeRoundedCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func animateRotate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 5
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
