//
//  PUPassengerRideViewController.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 05/08/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit
import MapKit
import Parse

class PUPassengerRideViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var targetName: String?
    var targetLocation: CLLocationCoordinate2D?
    
    init(targetName: String!, targetLocation: CLLocationCoordinate2D!) {
        super.init(nibName: "PUPassengerRideViewController", bundle: nil)
        self.targetName = targetName
        self.targetLocation = targetLocation
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLocation()
        addRideAnnotations()
    }
    
    // MARK: Setups
    
    func setupNavigationBar() {
        self.title = "Pedir Carona"
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func setupLocation() {
        PULocationManager.shared.setup(mapView, centerMapOnUserLocation: true)
    }
    
    // MARK: API calls
    
    func addRideAnnotations() {
        
    }
}

