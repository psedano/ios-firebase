//
//  InfoView.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/21/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit

class InfoView: UIView {
    
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var commentTableView: UITableView!
    
    override func awakeFromNib() {
        commentTableView.hidden = true
    }
    
}
