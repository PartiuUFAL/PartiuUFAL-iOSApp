//
//  PUMapViewController.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 18/07/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit
import MapKit

class PUMainViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var letsGoBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    func setupLayout() {
        self.letsGoBtn.layer.shadowColor = UIColor.black.cgColor
        self.letsGoBtn.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.letsGoBtn.layer.shadowRadius = 2
        self.letsGoBtn.layer.shadowOpacity = 0.5
    }
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.16, green:0.18, blue:0.21, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Slabo13px-Regular", size: 20)!, NSForegroundColorAttributeName: UIColor(red:0.16, green:0.18, blue:0.21, alpha:1.0)]

        
        let frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let imageViewLeft = UIImageView()
        imageViewLeft.contentMode = .scaleAspectFill
        imageViewLeft.frame = frame
        
        PUUser.current()?.picture?.fetchIfNeededInBackground()
        
        if let userImage = PUUser.current()?.picture?.objectId {
            PUMedia.findMediaById(id: userImage, completion: { (media, error) in
                if let media = media {
                    media.thumbnail.getDataInBackground(block: { (data, error) in
                        if data != nil {
                            imageViewLeft.image = UIImage(data: data!)
                        }
                    })
                }
            })
        }
        
        imageViewLeft.layer.cornerRadius = frame.width/2
        imageViewLeft.layer.masksToBounds = true
        
        let view = UIView(frame: frame)
        view.addSubview(imageViewLeft)
        
        let leftGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openProfile))
        view.addGestureRecognizer(leftGestureRecognizer)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
 
 
    }
    
    func setupLocation() {
        PULocationManager.shared.setup(mapView, centerMapOnUserLocation: true)
    }
    
    func openProfile() {
        self.navigationController?.pushViewController(PUProfileViewController(), animated: true)
    }
    
    @IBAction func letsGoBtnPressed(_ sender: Any) {
        let controller = PUSetupRideViewController(listener: self)
        controller.show(inViewController: self)
    }
}

extension PUMainViewController: PUSetupRideListener {
    func setupRide(targetName: String!, targetLocation: CLLocationCoordinate2D!, isPassenger: Bool!) {
        if isPassenger {
            self.navigationController?.pushViewController(PUPassengerRideViewController(targetName: targetName, targetLocation: targetLocation), animated: true)
        } else {
            self.navigationController?.pushViewController(PUDriverRideViewController(targetName: targetName, targetLocation: targetLocation), animated: true)
        }
    }
}

