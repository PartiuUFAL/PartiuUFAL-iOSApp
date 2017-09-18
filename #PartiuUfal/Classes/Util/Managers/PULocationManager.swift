//
//  PULocationManager.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 30/08/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation
import MapKit

class PULocationManager: NSObject {
    static let shared = PULocationManager()
    
    fileprivate let locationManager = CLLocationManager()
    fileprivate let regionRadius: CLLocationDistance = 2000
    fileprivate var location = CLLocation(latitude: -9.652376, longitude: -35.701397)
    fileprivate var userLocation:CLLocation?
    fileprivate var centerMapOnUserLocation = true
    var mapView: MKMapView?
    
    func setup(_ mapView: MKMapView, centerMapOnUserLocation: Bool) {
        self.mapView = mapView
        self.centerMapOnUserLocation = centerMapOnUserLocation
        
        self.mapView?.showsUserLocation = true
        self.mapView?.showsBuildings = true
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            userLocation = locationManager.location
            
            if let userLocation = self.userLocation {
                centerMapOnLocation(location: userLocation)
            }
            
        } else {
            centerMapOnLocation(location: location)
        }
    }
}

extension PULocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations.last!
        self.location = CLLocation(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        if centerMapOnUserLocation {
            centerMapOnLocation(location: userLocation!)
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        self.mapView?.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
