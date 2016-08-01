//
//  ImagePlace.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/21/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit

class ImagePlace: UIImageView {

    override func awakeFromNib() {
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }

}
