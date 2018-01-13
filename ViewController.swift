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
        
       
       
        if (location.count > 1){
            let sourceIndex = location.count - 1
            let destinationIndex = location.count - 2
            
            let x1 = location[sourceIndex].coordinate
            let x2 = location[destinationIndex].coordinate
            var y = [x1, x2]
            let polyline = MKPolyline(coordinates: &y, count: y.count)
            myMap.add(polyline, level: .aboveRoads)
        }
    
        
    }
    
    
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolyline{
        
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.black
            polylineRenderer.lineWidth = 5

            return polylineRenderer
        }
        return nil
        
    }
    
    
    @IBAction func LocateMe(_ sender: Any) {
        
        FirLat = LAT
        FirLong = LONG
        
        let CLLCoordType = CLLocationCoordinate2D(latitude: LAT,longitude: LONG)
        let anno = MKPointAnnotation();
        anno.coordinate = CLLCoordType;
        myMap.addAnnotation(anno)
        LocateMe.isHidden = true
    }
    
    @IBAction func TaskButt(_ sender: Any) {
        
        let FIRST = CLLocation(latitude: FirLat, longitude: FirLong)
        
        
        let LAST = CLLocation(latitude: LAT, longitude: LONG)
        
        
       let distance = FIRST.distance(from: LAST)
        
        
        
       DistaneOut.text = String(int_fast16_t(distance))
    }
}

