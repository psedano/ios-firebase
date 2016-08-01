//
//  MaterialButton.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/20/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {

    override func awakeFromNib() {
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.borderWidth = 1.0
        layer.backgroundColor = UIColor(colorLiteralRed: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 0.3).CGColor
    }

}
