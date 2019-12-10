//
//  CardImage.swift
//  Marvel app
//
//  Created by Misael Rivera on 08/12/19.
//  Copyright © 2019 Misael Rivera. All rights reserved.
//

import UIKit
@IBDesignable

class CardImage: UIImageView {
        
    override func awakeFromNib() {
        super.awakeFromNib()
        cardImageUI()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        cardImageUI()
    }
    
    private func cardImageUI() {
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.black.withAlphaComponent(1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.5
    }
}
