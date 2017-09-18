//
//  PUSearchLocationViewController.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 31/07/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark)
}

protocol PUSearchLocationDelegate {
    func didSelectLocation(named: String, at: CLLocationCoordinate2D)
}

class PUSearchLocationViewController: UIViewController {
    
    fileprivate var selectedPin:MKPlacemark? = nil
    fileprivate var tableViewController: PUSearchLocationTableViewController!
    fileprivate var searchController: UISearchController!
    fileprivate var delegate: PUSearchLocationDelegate!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var concludeBtn: UIButton!
    
    init(delegate: PUSearchLocationDelegate) {
        super.init(nibName: "PUSearchLocationViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupLocation()
        setupTableViewAndSearch()
        mapView.delegate = self
    }
    
    func setupLayout() {
        concludeBtn.layer.cornerRadius = concludeBtn.frame.height/2
        concludeBtn.layer.masksToBounds = true
    }
    
    fileprivate func setupTableViewAndSearch() {
        tableViewController = PUSearchLocationTableViewController(mapView: mapView, delegate: self)
        tableViewController.handleMapSearchDelegate = self
        
        searchController = UISearchController(searchResultsController: tableViewController)
        searchController.searchResultsUpdater = tableViewController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        let searchBar = searchController.searchBar
        searchBar.setValue("Cancelar", forKey:"_cancelButtonText")
        searchBar.sizeToFit()
        searchBar.placeholder = "Procure um local"
        searchBar.tintColor = .black
        searchBar.barTintColor = .white
        
        navigationItem.titleView = searchBar
    }
    
    func setupLocation() {
        PULocationManager.shared.setup(mapView, centerMapOnUserLocation: false)
    }
    
    @IBAction func concludeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension PUSearchLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let annotationIdentifier = "PULocationAnnotationView"
        
        var annotationView: MKAnnotationView?
        
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = #imageLiteral(resourceName: "annotation.place")
        }
        
        return annotationView
    }
}

extension PUSearchLocationViewController: PUSearchLocationDelegate {
    func didSelectLocation(named: String, at: CLLocationCoordinate2D) {
        self.searchController.isActive = false
        delegate.didSelectLocation(named: named, at: at)
    }
}

extension PUSearchLocationViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        selectedPin = placemark
        
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality, let state = placemark.administrativeArea {
            annotation.subtitle = "\(city), \(state)"
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}
