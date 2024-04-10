//
//  ViewController.swift
//  ShowMyLocation
//
//  Created by John Cagle on 09.04.24.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    var latitude: Double?
    var longitude: Double?
    var altitude: Double?
    let locationManager = CLLocationManager()

    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var myLatitude: UITextField!
    @IBOutlet weak var myLongitude: UITextField!
    @IBOutlet weak var myAltitude: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
        if status == .authorizedWhenInUse {
            print("GPS allowed.")
        }
        else {
            print("GPS not allowed.")
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let myCoordinate = location.coordinate
        altitude = location.altitude
        latitude = myCoordinate.latitude
        longitude = myCoordinate.longitude
        
        myLatitude.text = String(format: "%.6f", latitude ?? 0.0)
        myLongitude.text = String(format: "%.6f", longitude ?? 0.0)
        myAltitude.text = String(format: "%.2f", altitude ?? 0.0)
        
        let region = MKCoordinateRegion(center: myCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        myMap.setRegion(region, animated: true)
        
        myMap.showsUserLocation = true
    }
}
