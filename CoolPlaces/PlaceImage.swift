//
//  PlaceImage.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/20/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit

class PlaceImage: UIImageView {

    override func awakeFromNib() {
        layer.cornerRadius = frame.width / 2
        layer.zPosition = 1.0
    }
}
