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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var DistanceLabel: UILabel!
    
    @IBOutlet weak var DistaneOut: UITextField!
    
    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var LocateMe: UIButton!
    
    var manager = CLLocationManager()
    var CLLCoordTypeLocation: CLLocationCoordinate2D?
    
    var location: [CLLocation] = []
    
    
    
    var LAT:Double  = 0
    var LONG:Double  = 0
    
    var FirLat: Double = 0
    var FirLong: Double = 0
    
    var LASTLat: Double = 0
    var LASTLong: Double = 0
    
    var sourceItem: MKMapItem?
    
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
        
//        let CLLCoordType = CLLocationCoordinate2D(latitude: (location.first?.coordinate.latitude)!,longitude: (location.first?.coordinate.longitude)!)
//
//
//        let anno = MKPointAnnotation();
//        anno.coordinate = CLLCoordType;
//        anno.title = "Start"
//        myMap.addAnnotation(anno)
        
       
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        
        if annotation.title! == "Destination" {
            
            annotationView.pinTintColor = UIColor.green
            
        } else {
            
            annotationView.pinTintColor = UIColor.red
        }
        
        
        return annotationView
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









