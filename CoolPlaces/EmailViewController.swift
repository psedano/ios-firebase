//
//  EmailViewController.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/21/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit
import Firebase

class EmailViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        var str = NSAttributedString(string: "Correo electrónico", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        txtEmail.attributedPlaceholder = str
        
        str = NSAttributedString(string: "Contraseña", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        txtPassword.attributedPlaceholder = str
        swipeGesture.delegate = self
        self.view.addGestureRecognizer(swipeGesture)
    }
    
    @IBAction func btnEmail(sender: MaterialButton!){
        
        if let email = txtEmail.text where email != "", let pwd = txtPassword.text where pwd != "" {
            
            if isValidEmail(txtEmail.text!) {
                FIRAuth.auth()?.signInWithEmail(email, password: pwd, completion: { firUser, error in
                    
                    if error != nil {
                        print(error!.code)
                        
                        if error!.code == ERROR_USER_NOT_FOUND {
                            
                            FIRAuth.auth()?.createUserWithEmail(email, password: pwd, completion: { firUser, error in
                                
                                if error != nil {
                                    self.showErrorAlert("No se pudo crear la cuenta", msg: "Problema al crear la cuenta. Intentalo de nuevo")
                                } else {
                                    NSUserDefaults.standardUserDefaults().setValue(firUser?.uid, forKey: KEY_UID)
                                    
                                    //                                let user = ["provider":"Email", "username": "test"]
                                    //                                Dataservices.ds.createFirebaseUser(firUser!.uid, user: user)
                                    
                                    self.performSegueWithIdentifier(SEGUE_TO_MAIN_SCREEN, sender: nil)
                                }
                                
                            })
                            
                        } else if error!.code == ERROR_WRONG_PASSWORD {
                            self.showErrorAlert("Ingreso Incorrecto", msg: "La contraseña introducida no es correcta, favor de intentar de nuevo")
                        }
                    } else {
                        
                        if NSUserDefaults.standardUserDefaults().objectForKey(KEY_UID) == nil {
                            NSUserDefaults.standardUserDefaults().setValue(firUser?.uid, forKey: KEY_UID)
                        }
                        
                        NSUserDefaults.standardUserDefaults().setValue(firUser?.email, forKey: "currentUser")
                        self.performSegueWithIdentifier(SEGUE_TO_MAIN_SCREEN, sender: nil)
                    }
                
                })
            } else {
                showErrorAlert("Error", msg: "El formato de correo no es correcto")
            }
            
        } else {
            showErrorAlert("Error", msg: "Favor de proporcionar un usuario y una contraseña")
        }
        
    }
    
    func showErrorAlert(title: String, msg: String){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(alertAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        print(gestureRecognizer)
        performSegueWithIdentifier("toFirstScreen", sender: nil)
        
        return true
    }

}
