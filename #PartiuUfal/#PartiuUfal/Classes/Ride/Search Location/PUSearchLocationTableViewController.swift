//
//  PUSearchLocationTableViewController.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 31/07/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit
import MapKit

class PUSearchLocationTableViewController: UITableViewController {
    fileprivate var foundLocations = [MKMapItem]()
    fileprivate var mapView: MKMapView!
    fileprivate var delegate: PUSearchLocationDelegate!
    var handleMapSearchDelegate:HandleMapSearch?
    
    init(mapView: MKMapView, delegate: PUSearchLocationDelegate) {
        super.init(nibName: "PUSearchLocationTableViewController", bundle: nil)
        self.mapView = mapView
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PUSearchLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "PUSearchLocationTableViewCell")
        tableView.estimatedRowHeight = 63
        tableView.rowHeight = 63
    }
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        let firstSpace = (selectedItem.subThoroughfare != nil &&
            selectedItem.thoroughfare != nil) ? " " : ""
        
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) &&
            (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        
        let secondSpace = (selectedItem.subAdministrativeArea != nil &&
            selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            selectedItem.thoroughfare ?? "",
            comma,
            selectedItem.locality ?? "",
            secondSpace,
            selectedItem.administrativeArea ?? ""
        )
        
        return addressLine
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundLocations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PUSearchLocationTableViewCell", for: indexPath) as! PUSearchLocationTableViewCell
        cell.setup(locationNamed: foundLocations[indexPath.row].name!, address: parseAddress(selectedItem: foundLocations[indexPath.row].placemark))
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = foundLocations[indexPath.row]
        handleMapSearchDelegate?.dropPinZoomIn(placemark: location.placemark)
        delegate.didSelectLocation(named: location.name!, at: location.placemark.coordinate)
    }
}

extension PUSearchLocationTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBarText = searchController.searchBar.text
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.foundLocations = response.mapItems
            self.tableView.reloadData()
        }
    }
}
