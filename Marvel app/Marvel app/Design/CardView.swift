//
//  CardView.swift
//  Marvel app
//
//  Created by Misael Rivera on 24/11/19.
//  Copyright © 2019 Misael Rivera. All rights reserved.
//

import UIKit
@IBDesignable

class CardView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardViewUI()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        cardViewUI()
    }
    
    private func cardViewUI() {
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.black.withAlphaComponent(1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.5
    }
}
