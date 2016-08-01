//
//  DetailViewController.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/21/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var mkMapView: MKMapView!
    @IBOutlet weak var infoView: InfoView!
    @IBOutlet weak var btnInfoBtn: UIButton!
    @IBOutlet weak var btnCommentBtn: UIButton!
    @IBOutlet weak var lblLugar: UILabel!
    @IBOutlet weak var lblEstado: UILabel!
    @IBOutlet weak var imgPlace: UIImageView!
    @IBOutlet weak var tblComments: CommentTableView!
    @IBOutlet weak var imgComment: UIImageView!
    
    var currentPlace: Place!
    var currentImage: UIImage!
    var indexPath: Int!
    var arrComments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblComments.dataSource = self
        tblComments.delegate = self
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.hidesBackButton = false
        let titleDict = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes =  titleDict
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 0.220, green: 0.220, blue: 0.220, alpha: 1.0)

        let latitude: CLLocationDegrees = currentPlace.lat
        let longitude: CLLocationDegrees = currentPlace.lon
        let latDelta = 0.05
        let lonDelta = 0.05
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let locationCoordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(locationCoordinate, span)
        
        mkMapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        annotation.title = currentPlace.lugar
        
        lblLugar.text = currentPlace.lugar
        lblEstado.text = currentPlace.estado
        
        infoView.infoTextView.text = currentPlace.descripcion
    
        mkMapView.addAnnotation(annotation)
        
        imgPlace.image = currentImage
        imgPlace.clipsToBounds = true
        
        Dataservices.ds.REF_BASE.child("places/\(indexPath)/comments").observeEventType(.Value, withBlock: { snapshot in
            
            if snapshot.childrenCount > 0 {
                print(snapshot)
                
                let dictComments = (snapshot as FIRDataSnapshot).value as? Dictionary<String, AnyObject>
                
                for snap in dictComments!.values {
                    let comment = Comment()
                    comment.setUser(snap.objectForKey("user") as! String)
                    comment.setText(snap.objectForKey("text") as! String)
                    
                    self.arrComments.append(comment)
                }
                
                self.tblComments.reloadData()
                
            }
        })
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrComments.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellComment") as! CommentTableViewCell
        
        cell.lblUsuario.text = arrComments[indexPath.row].user
        cell.lblComentario.text = arrComments[indexPath.row].text
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    @IBAction func btnComentario(sender: AnyObject) {
        
            UIView.animateWithDuration(1) {
                self.infoView.infoTextView.hidden = true
                self.infoView.commentTableView.hidden = false
                self.btnCommentBtn.layer.borderWidth = 2.0
                self.btnCommentBtn.layer.borderColor = UIColor(colorLiteralRed: 1.000, green: 0.804, blue: 0.000, alpha: 1.0).CGColor
                
                self.btnInfoBtn.layer.borderWidth = 0.0
                self.btnInfoBtn.layer.borderColor = UIColor.whiteColor().CGColor
            }
        
    }
    
    @IBAction func btnInfo(sender: AnyObject) {
        UIView.animateWithDuration(2) { 
            self.infoView.infoTextView.hidden = false
            self.infoView.commentTableView.hidden = true
            self.btnInfoBtn.layer.borderWidth = 2.0
            self.btnInfoBtn.layer.borderColor = UIColor(colorLiteralRed: 1.000, green: 0.804, blue: 0.000, alpha: 1.0).CGColor
            
            self.btnCommentBtn.layer.borderWidth = 0.0
            self.btnCommentBtn.layer.borderColor = UIColor.whiteColor().CGColor
        }
    }
    
    @IBAction func gestureRecognizer(sender: UITapGestureRecognizer) {
        let popupVC = storyboard?.instantiateViewControllerWithIdentifier("PopupVC") as! PopoverViewController
        popupVC.modalPresentationStyle = .Popover
        popupVC.preferredContentSize = CGSizeMake(300, 400)
        popupVC.placeName = currentPlace.lugar
        popupVC.indexOfPost = indexPath
        
        let popoverVC = popupVC.popoverPresentationController
        popoverVC?.permittedArrowDirections = .Any
        popoverVC?.sourceView = imgComment
        popoverVC?.delegate = self
        
        presentViewController(popupVC, animated: true, completion: nil)
        
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
}
