//
//  LoginBackground.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/20/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit

class LoginBackground: UIImageView {

    override func awakeFromNib() {
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.alpha = 0.9
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        addSubview(blurEffectView)
        layer.zPosition = 0.0
    }

}
