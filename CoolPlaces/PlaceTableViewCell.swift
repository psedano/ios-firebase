//
//  PlaceTableViewCell.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/21/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit
import Alamofire

class PlaceTableViewCell: UITableViewCell {
    
    var request: Request?
    
    @IBOutlet weak var tvTransparentView: UIView!
    @IBOutlet weak var imgPlace: UIImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(title: String, subTitle: String, urlImage: String){
        lblTitle.text = title
        lblSubtitle.text = subTitle
        
        if let image = MainViewController.imgCache.objectForKey(urlImage) as? UIImage {
            self.imgPlace.image = image
        } else {
            request = Alamofire.request(.GET, urlImage).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, error in
                
                if error == nil {
                    let img = UIImage(data: data!)!
                    self.imgPlace.image = img
                    
                    MainViewController.imgCache.setObject(img, forKey: urlImage)
                }
                
            })
        }
        
    }

}
