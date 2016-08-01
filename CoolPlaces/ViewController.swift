//
//  ViewController.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/20/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var lblCoolPlaces: UILabel!
    @IBOutlet weak var imgPlace1: PlaceImage!
    @IBOutlet weak var imgPlace2: PlaceImage!
    @IBOutlet weak var imgPlace3: PlaceImage!
    @IBOutlet weak var imgPlace4: PlaceImage!
    
    @IBOutlet weak var layoutTopLabel: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       setNeedsStatusBarAppearanceUpdate()
        lblCoolPlaces.layer.zPosition = 1.0
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupAnimations()
        beginAnimations()
    }
    
    func setupAnimations(){
        lblCoolPlaces.alpha = 0.0
        layoutTopLabel.constant = 300
        imgPlace1.alpha = 0.0
        imgPlace2.alpha = 0.0
        imgPlace3.alpha = 0.0
        imgPlace4.alpha = 0.0
    }
    
    func beginAnimations() {
        
        UIView.animateWithDuration(2, animations: {
            
        }) { success in
        
           self.layoutTopLabel.constant = 30
            
           UIView.animateWithDuration(0.8, animations: {
                self.view.layoutIfNeeded()
                self.lblCoolPlaces.alpha = 1.0
                self.imgPlace1.alpha = 1.0
                self.imgPlace2.alpha = 1.0
                self.imgPlace3.alpha = 1.0
                self.imgPlace4.alpha = 1.0
           })
        }
    }
    
    func prefferedStatusBarStyle() -> UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }

    @IBAction func btnFacebookLogin(sender: UIButton) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self) { facebookResult, facebookError in
            
            if facebookError != nil {
                print("Facebook Login failed. Error \(facebookError)")
            } else {
                
                if facebookResult.isCancelled == false {
                    let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                    print("Successfully login with Facebook! \(accessToken)")
                    
                    let credential = FIRFacebookAuthProvider.credentialWithAccessToken(accessToken)
                    
                    FIRAuth.auth()?.signInWithCredential(credential, completion: { (firUser: FIRUser?, error: NSError?) in
                        
                        if error != nil {
                            print("Login failed. \(error)")
                            
                            if error!.code == ERROR_EMAIL_ALREADY_IN_USE {
                                self.showErrorAlert("Login Error", msg: "The account is already in use")
                            }
                            
                        } else {
                            
                            print("Logged In! \(firUser!)")
                            
                            //                        let user = ["provider":"Facebook", "username": "test"]
                            //                        Dataservices.ds.createFirebaseUser(firUser!.uid, user: user)
                            
                            NSUserDefaults.standardUserDefaults().setValue(firUser?.uid, forKey: KEY_UID)
                            NSUserDefaults.standardUserDefaults().setValue(firUser?.email, forKey: "currentUser")
                            self.performSegueWithIdentifier(SEGUE_COOL_PLACES_MAIN, sender: nil)
                            
                            
                        }
                    })
                }
            }

            
        }
    }
    
    func showErrorAlert(title: String, msg: String){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(alertAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
}

