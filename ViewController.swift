//
//  ViewController.swift
//  Location-and-maping
//
//  Created by Basma Ahmed Mohamed Mahmoud on 7/30/18.
//  Copyright © 2018 Basma Ahmed Mohamed Mahmoud. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var startPoint: UIButton!
    @IBOutlet weak var endPoint: UIButton!
    @IBOutlet weak var distanceOutLet: UILabel!
    
    
    //We created a manager of type CLLocationManger, created an array of CLLocation’s and name that Location.
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
        //Setup our Location Manager, and our Map View
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        self.myMap.showsUserLocation = true
    }

    // This function gets called every time our location change.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // here we are storing our first latitude and longitude
        LAT = locations[0].coordinate.latitude
        LONG = locations[0].coordinate.longitude
        
        // here we are storing all our latitudes and longitudes.
        location.append(locations[0] as CLLocation)
        
        //The map will display our location, but it will be zoomed out. If we want to zoom into our location, the span refers to how zoomed in
        // we actually are in the region.
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myMap.userLocation.coordinate, span)
        myMap.setRegion(region, animated: true)
    }
    
    // this button give us the coordinate that we want to start from it our distance calculation
    
    @IBAction func startButtn(_ sender: Any) {
        // here we got our first point of distance calculating coordinates
        FirLat = LAT
        FirLong = LONG
        CLLCoordTypeLocation = CLLocationCoordinate2D(latitude: LAT,longitude: LONG)
        
        // here we put our annotation on our mapkit(the start point)
        let anno = MKPointAnnotation();
        anno.coordinate = CLLCoordTypeLocation!;
        anno.title = "New Start"
        myMap.addAnnotation(anno)
        startPoint.isHidden = true
    }

    
    // This button calculate the distance travelled from the first point where we tapped the locate button at.
    @IBAction func endButtn(_ sender: Any) {
        var distance:Double!
        
        // here First and Last refers to the coordinate of the first pointyou are in when you tapped the locate button
        // and the last point coordinate when you tapped task button
        let FIRST = CLLocation(latitude: FirLat, longitude: FirLong)
        let LAST = CLLocation(latitude: LAT, longitude: LONG)
        
        // here xx and yy refer to the coordinates of first and last point you achieved since you opened the application
        let xx = CLLocation(latitude: (location.first?.coordinate.latitude)!, longitude: (location.first?.coordinate.longitude)!)
        let yy = CLLocation(latitude: (location.last?.coordinate.latitude)!, longitude: (location.last?.coordinate.longitude)!)
        
        if startPoint.isHidden == true{
            
            distance = FIRST.distance(from: LAST)
            
        }else{
            
            distance = xx.distance(from: yy)
        }
        distanceOutLet.text = String("Distance = ") + String(intmax_t(distance))
        
        myMap.removeAnnotations(myMap.annotations)
        
        let anno = MKPointAnnotation();
        anno.coordinate = CLLCoordTypeLocation!;
        anno.title = "New Start"
        myMap.addAnnotation(anno)
        
        let CLLCoordTypeD = CLLocationCoordinate2D(latitude: (location.last?.coordinate.latitude)!,longitude: (location.last?.coordinate.longitude)!)
        let annoD = MKPointAnnotation();
        annoD.coordinate = CLLCoordTypeD;
        annoD.title = "Destination"
        myMap.addAnnotation(annoD)
    }
  
}

