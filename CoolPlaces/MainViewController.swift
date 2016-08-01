//
//  MainViewController.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/20/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrPlaces = [Place]()
    static var imgCache = NSCache()
    var currentIndexPath = 0
    
    @IBOutlet weak var placesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            navigationController?.setNavigationBarHidden(false, animated: false)
            navigationItem.hidesBackButton = true
            let titleDict = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            navigationController?.navigationBar.titleTextAttributes =  titleDict
            navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 0.220, green: 0.220, blue: 0.220, alpha: 1.0)
        
        placesTableView.delegate = self
        placesTableView.dataSource = self
        
        Dataservices.ds.REF_BASE.child("places").observeEventType(.Value, withBlock: { snapshot in
            
            let arrSnapPlaces = (snapshot as FIRDataSnapshot).value as? Array<AnyObject>
            
            for singlePlace in arrSnapPlaces! {
                print(singlePlace)
                
//                let dictdict = singlePlace.objectForKey("comments") as? Dictionary<String, AnyObject>
//                var arrComments: [Comment]?
//                
//                if dictdict != nil {
//                    arrComments = [Comment]()
//                    
//                    for value in dictdict!.values {
//                        print(value)
//                        let objComment = Comment()
//                        objComment.setText(value.objectForKey("text") as! String)
//                        objComment.setUser(value.objectForKey("user") as! String)
//                        
//                        arrComments!.append(objComment)
//                    }
//                } else {
//                    arrComments = nil
//                }
            
                let place = Place(descripcion: singlePlace.objectForKey("descripcion") as! String, estado: singlePlace.objectForKey("estado") as! String, placeId: singlePlace.objectForKey("id") as! Int, imagen: singlePlace.objectForKey("imagen") as! String, lat: singlePlace.objectForKey("lat") as! Double, lon: singlePlace.objectForKey("lon") as! Double, lugar: singlePlace.objectForKey("lugar") as! String)
                
                self.arrPlaces.append(place)
            }
            
            self.placesTableView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPlaces.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! PlaceTableViewCell
        
        cell.configureCell(arrPlaces[indexPath.row].lugar, subTitle: arrPlaces[indexPath.row].estado, urlImage: arrPlaces[indexPath.row].imagen)
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentIndexPath = indexPath.row
        performSegueWithIdentifier("toDetails", sender: arrPlaces[indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailVC: DetailViewController = segue.destinationViewController as! DetailViewController
        detailVC.currentPlace = sender as! Place
        detailVC.indexPath = currentIndexPath
        let imgUrlString = (sender as! Place).imagen
        detailVC.currentImage = MainViewController.imgCache.objectForKey(imgUrlString) as? UIImage
    }

}
