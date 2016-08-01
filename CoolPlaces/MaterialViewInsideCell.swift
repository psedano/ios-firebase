//
//  MaterialViewInsideCell.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/20/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit

class MaterialViewInsideCell: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = 5.0
        layer.shadowOpacity = 0.8
        layer.shadowColor = UIColor(colorLiteralRed: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0).CGColor
        layer.shadowOffset = CGSizeMake(0.0, 1.0)
    }

}
