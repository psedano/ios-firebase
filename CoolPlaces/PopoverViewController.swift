//
//  PopoverViewController.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/22/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    
    @IBOutlet weak var lblPlaceName: UILabel!
    var placeName = String()
    var indexOfPost: Int!

    @IBOutlet weak var comentario: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblPlaceName.text = placeName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnAceptar(sender: UIButton) {
        let post: Dictionary<String, String> = [
            "text": comentario.text!,
            "uid": NSUserDefaults.standardUserDefaults().objectForKey(KEY_UID) as! String,
            "user": NSUserDefaults.standardUserDefaults().objectForKey(KEY_CURRENT_USER) as! String
        ]
    
        let fireBasePost = Dataservices.ds.REF_BASE.child("places/\(indexOfPost)/comments").childByAutoId()
        fireBasePost.setValue(post)
        dismissViewControllerAnimated(true, completion: nil)

        
        //showAlert("Comentario", msg: "Se ha publicado tu comentario")
    }

    
    @IBAction func btnCancelar(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    func showAlert(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .ActionSheet)
        let alertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertController.addAction(alertAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}
