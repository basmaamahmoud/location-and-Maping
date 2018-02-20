//
//  ViewController.swift
//  MVPProject
//
//  Created by Basma Ahmed Mohamed Mahmoud on 1/8/18.
//  Copyright © 2018 Basma Ahmed Mohamed Mahmoud. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// We have added CCLocationManagerDelegate and MKMapViewDelegate as classes we are inheriting from, we use it for location and using mapkit.
class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var DistanceLabel: UILabel!
    
    @IBOutlet weak var DistaneOut: UITextField!
    
    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var LocateMe: UIButton!
    
    
    //We create a manager of type CLLocationManger 
//  //We created an array of CLLocation’s and name that Location. 
   
    var manager = CLLocationManager()
    var location: [CLLocation] = []
    
    
    
    
    
    
   // initiate some variables to use it for latitude and longitude used in distance calculating. 
    
    var CLLCoordTypeLocation: CLLocationCoordinate2D?
    
    var LAT:Double  = 0
    var LONG:Double  = 0
    
    var FirLat: Double = 0
    var FirLong: Double = 0
    
    var LASTLat: Double = 0
    var LASTLong: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        self.myMap.showsUserLocation = true
    
        
  
       
    }
    
   
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        LAT = locations[0].coordinate.latitude
        LONG = locations[0].coordinate.longitude
        
        location.append(locations[0] as CLLocation)
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myMap.userLocation.coordinate, span)
        
        myMap.setRegion(region, animated: true)
        
       
        
    }
    
   
    
    
    @IBAction func LocateMe(_ sender: Any) {
        
        FirLat = LAT
        FirLong = LONG
        
        
       CLLCoordTypeLocation = CLLocationCoordinate2D(latitude: LAT,longitude: LONG)
        
       
        let anno = MKPointAnnotation();
        anno.coordinate = CLLCoordTypeLocation!;
        anno.title = "New Start"
        myMap.addAnnotation(anno)
        LocateMe.isHidden = true
       
        
        
        
    }
    
    @IBAction func TaskButt(_ sender: Any) {
        var distance:Double!
        
        let FIRST = CLLocation(latitude: FirLat, longitude: FirLong)
        let xx = CLLocation(latitude: (location.first?.coordinate.latitude)!, longitude: (location.first?.coordinate.longitude)!)
        
        let LAST = CLLocation(latitude: LAT, longitude: LONG)
        let yy = CLLocation(latitude: (location.last?.coordinate.latitude)!, longitude: (location.last?.coordinate.longitude)!)
        
        if LocateMe.isHidden == true{
            
           distance = FIRST.distance(from: LAST)
            
        }else{
            
            distance = xx.distance(from: yy)
            
            
        }
    
        
        myMap.removeAnnotations(myMap.annotations)
       DistaneOut.text = String(intmax_t(distance))
        
        let anno = MKPointAnnotation();
        anno.coordinate = CLLCoordTypeLocation!;
        anno.title = "New Start"
        myMap.addAnnotation(anno)
        
        
        
        let CLLCoordTypeD = CLLocationCoordinate2D(latitude: (location.last?.coordinate.latitude)!,longitude: (location.last?.coordinate.longitude)!)
        let annoD = MKPointAnnotation();
        annoD.coordinate = CLLCoordTypeD;
        
        annoD.title = "Destination"
        myMap.addAnnotation(annoD)
        //myMap.showsUserLocation = false
        
    }
}









