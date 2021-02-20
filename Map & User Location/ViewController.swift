//
//  ViewController.swift
//  Map & User Location
//
//  Created by sophia adkins on 2/18/21.
//

import UIKit
import MapKit

struct Trail {
  var name: String
  var lattitude: CLLocationDegrees
  var longtitude: CLLocationDegrees
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let radius: CLLocationDistance = 500
    
    //Lyme-Old Lyme Highschool Commons
    let startingLocation = CLLocation(latitude: 41.318403, longitude: -72.325362)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //setting starting location
        setStartingPosition()
        let store = getStoreLocation()
        setAnnotation(stores: store)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isLocationServiceEnabled()
    }
    
    
    func setStartingPosition(){
        
        let position =  MKCoordinateRegion(center: startingLocation.coordinate,
                                           latitudinalMeters: radius,
                                           longitudinalMeters: radius)
    
        mapView.setRegion(position, animated: true)
    }
    
    func isLocationServiceEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            checkAuthorizationStatus()
        }
        else{
            displayAlert(isServiceEnabled: true)
        }
    }
    
    func checkAuthorizationStatus(){
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
        else if status == .restricted || status == .denied {
            displayAlert(isServiceEnabled: false)
        }
        else if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        }
        
    }
    
    func displayAlert(isServiceEnabled:Bool){
        let serviceEnableMessage = "Location services must to be enabled to use the Lyme-Old Lyme Trails App map feature. You can enable location services in your settings."
        let authorizationStatusMessage = "The Lyme-Old Lyme Trails app needs authorization to do some cool stuff with the map"
        
        let message = isServiceEnabled ? serviceEnableMessage : authorizationStatusMessage
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        //create ok button
        let acceptAction = UIAlertAction(title: "OK", style: .default)
        
        //add ok button to alert
        alert.addAction(acceptAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func getStoreLocation() -> [Trail]{
        return [
            Trail(name: "Belton Copp Preserve", lattitude: 41.294780, longtitude: -72.322962),
            Trail(name: "Boggy Hole Preserve", lattitude: 41.329761, longtitude: -72.314710),
            Trail(name: "DeGernday Preserve", lattitude: 41.342818, longtitude: -72.312222),
            Trail(name: "Goberis Chadwick Preserve", lattitude: 41.296416, longtitude:  -72.262609),
            Trail(name: "Griswold Preserve", lattitude: 41.334376, longtitude: -72.317773),
            Trail(name: "Hatchett's Hill Preserve", lattitude: 41.315828, longtitude: -72.272182),
            Trail(name: "Heller's Preserve", lattitude: 41.357180, longtitude: -72.318170),
            Trail(name: "Jericho Preserve", lattitude: 41.336956, longtitude: -72.300718),
            Trail(name: "Lay-Allen Preserve", lattitude: 41.344600, longtitude: -72.285588),
            Trail(name: "Lohmann Buck Twining Preserve", lattitude: 41.336605, longtitude: -72.334285),
            Trail(name: "John Lohmann CT River Preserve", lattitude: 41.346743, longtitude: -72.344894),
            Trail(name: "Mile Creek Preserve", lattitude: 41.297609, longtitude: -72.287347),
            Trail(name: "Upper Three Mile River Preserve", lattitude: 41.326862, longtitude: -72.262858),
            Trail(name: "Watch Rock Preserve", lattitude: 41.302572, longtitude: -72.328826)
        ]
    }
    
    func setAnnotation(stores:[Trail]){
        
        for store in stores {
            let annotation = MKPointAnnotation()
            annotation.title = store.name
            
            
            annotation.coordinate = CLLocationCoordinate2D(latitude:store.lattitude,
                                                         longitude: store.longtitude)
            mapView.addAnnotation(annotation)
        }
    }
}
