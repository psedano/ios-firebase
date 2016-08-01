//
//  swipeSegue.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/20/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit

class SwipeSegue: UIStoryboardSegue {
    
    override func perform() {
        let sourceVC = self.sourceViewController
        let destinationVC = self.destinationViewController
        let transition = CATransition()
        let timeFunc = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        transition.duration = 0.5
        transition.timingFunction = timeFunc
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromRight
        sourceVC.navigationController!.view.layer.addAnimation(transition, forKey: kCATransition)
        sourceVC.navigationController!.pushViewController(destinationVC, animated: false)
    }
}
