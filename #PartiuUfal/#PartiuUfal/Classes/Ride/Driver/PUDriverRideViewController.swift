//
//  PUDriverRideViewController.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 05/08/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit
import MapKit

class PUDriverRideViewController: UIViewController {

    var targetName: String?
    var targetLocation: CLLocationCoordinate2D?
    var ride: PURide?

    @IBOutlet weak var mapView: MKMapView!
    
    init(targetName: String!, targetLocation: CLLocationCoordinate2D!) {
        super.init(nibName: "PUDriverRideViewController", bundle: nil)
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
        createRide()
    }
    
    func createRide() {
        ride = PURide()
        ride?.driver = PUUser.current()
        ride?.passengers = []
        ride?.targetName = targetName
        ride?.isActive = NSNumber(booleanLiteral: true)
        ride?.saveInBackground { (success, error) in
            if success {
                print("Salvou corrida com sucesso")
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func setupNavigationBar() {
        self.title = "Carona"
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func setupLocation() {
        PULocationManager.shared.setup(mapView, centerMapOnUserLocation: true)
    }
}

