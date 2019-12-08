//
//  HeroeCell.swift
//  Marvel app
//
//  Created by Misael Rivera on 01/12/19.
//  Copyright © 2019 Misael Rivera. All rights reserved.
//

import UIKit
import Kingfisher

class HeroeCell: UITableViewCell {

    static let VARIANT_NAME = "standard_large"
    
    @IBOutlet weak var heroeName: UILabel!
    @IBOutlet weak var heroeImage: UIImageView!
    
    func updateHeroeCell(heroeName: String, heroeImage: String, imageExt: String) {
        self.heroeName.text = heroeName
        self.heroeImage.kf.setImage(with: URL(string: heroeImage+"/"+HeroeCell.VARIANT_NAME+"."+imageExt))
    }

}
