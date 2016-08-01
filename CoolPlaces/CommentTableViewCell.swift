//
//  CommentTableViewCell.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/22/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblUsuario: UILabel!
    @IBOutlet weak var lblComentario: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
