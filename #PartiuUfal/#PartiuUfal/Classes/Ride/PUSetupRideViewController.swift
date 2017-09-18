//
//  PUSetupRideViewController.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 27/07/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit
import CoreLocation

protocol PUSetupRideListener {
    func setupRide(targetName: String!, targetLocation: CLLocationCoordinate2D!, isPassenger: Bool!)
}

class PUSetupRideViewController: UIViewController {

    @IBOutlet weak var letsGoBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var btDriver: UIButton!
    @IBOutlet weak var btPassenger: UIButton!
    @IBOutlet weak var isAtUFALSwitch: UISwitch!
    @IBOutlet weak var lblIsAtUFALDescribing: UILabel!
    @IBOutlet weak var tfTargetLocation: UITextField!
    @IBOutlet weak var locationStackView: UIStackView!
    
    var listener: PUSetupRideListener?
    
    fileprivate var selectedLocation: CLLocationCoordinate2D?
    let campusPicker = UIPickerView()
    let logtin = CLLocationCoordinate2D()
    let campus = [
        "A.C. Simões": CLLocationCoordinate2D(latitude: -9.556164146, longitude: -35.77886403),
        "Centro de Ciências Agrárias": CLLocationCoordinate2D(latitude: -9.465968735, longitude: -35.82616111),
        "Unidade Arapiraca": CLLocationCoordinate2D(latitude: -9.700962456, longitude: -36.68705839),
        "Unidade Viçosa": CLLocationCoordinate2D(latitude: -9.403450943, longitude: -36.26271057),
        "Unidade Sertão": CLLocationCoordinate2D(latitude: -9.35031303, longitude: -37.98772139),
        "Unidade P. dos Índios": CLLocationCoordinate2D(latitude: -9.422592402, longitude: -36.6433317),
        "Unidade Santana do Ipanema": CLLocationCoordinate2D(latitude: -9.372225363, longitude: -37.2419341),
        "Unidade Penedo": CLLocationCoordinate2D(latitude: -10.29725526, longitude: -36.57877592)
    ]
    
    fileprivate var btDriverColors = (selected: UIColor(red:0.24, green:0.51, blue:0.35, alpha:1.0), unselected: UIColor(red:0.71, green:0.84, blue:0.75, alpha:1.0))
    fileprivate var btPassengerColors = (selected: UIColor(red:0.25, green:0.47, blue:0.67, alpha:1.0), unselected: UIColor(red:0.81, green:0.84, blue:0.89, alpha:1.0))
    
    // MARK: Constructors
    
    init(listener: PUSetupRideListener!) {
        super.init(nibName: "PUSetupRideViewController", bundle: nil)
        self.listener = listener
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTextField()
        setupPicker()
    }
    
    // MARK: Setups

    func setupLayout() {
        isAtUFALSwitch.setOn(false, animated: false)
        lblIsAtUFALDescribing.text = "Não"
        
        btDriver.setTitle("", for: .selected)
        btDriver.setImage(#imageLiteral(resourceName: "btn.confirm-green"), for: .selected)
        
        btPassenger.isSelected = true
        btPassenger.setTitle("", for: .selected)
        btPassenger.setImage(#imageLiteral(resourceName: "btn.confirm-blue"), for: .selected)
        
        letsGoBtn.isEnabled = false
        letsGoBtn.layer.opacity = 0.5
        
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.contentView.layer.shadowRadius = 10
        self.contentView.layer.shadowOpacity = 0.5
    }
    
    func setupTextField() {
        tfTargetLocation.addTarget(self, action: #selector(tfTargetLocationPressed(_:)), for: .editingDidBegin)
        tfTargetLocation.inputView = campusPicker
        tfTargetLocation.delegate = self
    }
    
    func setupPicker() {
        campusPicker.dataSource = self
        campusPicker.delegate = self
        campusPicker.backgroundColor = .white
    }
    
    @IBAction func passengerBtnPressed(_ sender: Any) {
        btPassenger.setBackgroundColor(to: btPassengerColors.selected, animated: true)
        btPassenger.isSelected = true
        btDriver.setBackgroundColor(to: btDriverColors.unselected, animated: true)
        btDriver.isSelected = false
    }
    
    @IBAction func driverBtnPressed(_ sender: Any) {
        btDriver.setBackgroundColor(to: btDriverColors.selected, animated: true)
        btDriver.isSelected = true
        btPassenger.setBackgroundColor(to: btPassengerColors.unselected, animated: true)
        btPassenger.isSelected = false
    }
    
    @IBAction func isAtUfalSwitchChanged(_ sender: Any) {
        if isAtUFALSwitch.isOn {
            lblIsAtUFALDescribing.text = "Sim"
            tfTargetLocation.inputView = nil
            tfTargetLocation.text = ""
            self.letsGoBtn.isEnabled = false
            self.letsGoBtn.layer.opacity = 0.5
        } else {
            lblIsAtUFALDescribing.text = "Não"
            tfTargetLocation.inputView = campusPicker
            tfTargetLocation.text = ""
            self.letsGoBtn.isEnabled = false
            self.letsGoBtn.layer.opacity = 0.5
        }
    }
    
    @IBAction func letsGoBtnPressed(_ sender: Any) {
        self.close(block: {
            if self.btPassenger.isSelected {
                self.listener?.setupRide(targetName: self.tfTargetLocation.text, targetLocation: self.selectedLocation, isPassenger: true)
            } else {
                self.listener?.setupRide(targetName: self.tfTargetLocation.text, targetLocation: self.selectedLocation, isPassenger: false)
            }
        })
    }

    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.close()
    }
    
    func tfTargetLocationPressed(_ textField: UITextField) {
        if isAtUFALSwitch.isOn {
            self.show(UINavigationController(rootViewController: PUSearchLocationViewController(delegate: self)), sender: self)
        }
    }
}

extension PUSetupRideViewController: PUSearchLocationDelegate {
    func didSelectLocation(named: String, at: CLLocationCoordinate2D) {
        tfTargetLocation.text = named
        selectedLocation = at
        self.letsGoBtn.isEnabled = true
        self.letsGoBtn.layer.opacity = 1
    }
}

extension PUSetupRideViewController {
    func show(_ animated: Bool = true, inViewController: UIViewController){
        if animated == true {
            self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            inViewController.present(self, animated: animated) { () -> Void in
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    self.view.backgroundColor  = UIColor.black.withAlphaComponent(0.5)
                })
            }
        }
    }
    
    func close() -> Void {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.backgroundColor = self.view.backgroundColor?.withAlphaComponent(0)
        }, completion: { (finished) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    func close(block: @escaping () -> ()) -> Void {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.backgroundColor = self.view.backgroundColor?.withAlphaComponent(0)
        }, completion: { (finished) -> Void in
            self.dismiss(animated: true, completion: nil)
            block()
        })
    }
}

extension PUSetupRideViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return campus.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let array = Array(campus.keys).sorted()
        return array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let array = Array(campus.keys).sorted()
        self.tfTargetLocation.text = array[row]
        self.selectedLocation = campus[self.tfTargetLocation.text!]
        
        if tfTargetLocation.text != "" {
            self.letsGoBtn.isEnabled = true
            self.letsGoBtn.layer.opacity = 1
        } else {
            self.letsGoBtn.isEnabled = false
            self.letsGoBtn.layer.opacity = 0.5
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension PUSetupRideViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            self.letsGoBtn.isEnabled = true
            self.letsGoBtn.layer.opacity = 1
        } else {
            self.letsGoBtn.isEnabled = false
            self.letsGoBtn.layer.opacity = 0.5
        }
    }
}


