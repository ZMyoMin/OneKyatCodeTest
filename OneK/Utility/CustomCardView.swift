//
//  CustomCardView.swift
//  OneK
//
//  Created by BCMM on 26/01/2022.
//

import UIKit

@IBDesignable class CustomCardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 5
    
    var ofsetWidth:CGFloat = 15
    var ofsetHeight:CGFloat = 15
    
    
    var ofsetShadowOpacity: Float = 15
    @IBInspectable var color = UIColor.red
    
    override func layoutSubviews() {
        layer.cornerRadius = self.cornerRadius
        layer.shadowColor = self.color.cgColor
        layer.shadowOffset = CGSize(width: self.ofsetWidth, height: self.ofsetHeight)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornerRadius).cgPath
        layer.shadowOpacity = self.ofsetShadowOpacity
    }
}
