//
//  PUEditProfileViewController.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 02/07/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import TPKeyboardAvoiding
import SwiftValidator
import ImagePicker
import Parse

class PUEditProfileViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var concludeBtn: UIButton!
    @IBOutlet weak var tfName: SkyFloatingLabelTextField!
    @IBOutlet weak var tfNickname: SkyFloatingLabelTextField!
    @IBOutlet weak var tfEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var tfGender: SkyFloatingLabelTextField!
    @IBOutlet weak var tfMaritalStatus: SkyFloatingLabelTextField!
    @IBOutlet weak var tfBirthdate: SkyFloatingLabelTextField!
    @IBOutlet weak var scrollView: TPKeyboardAvoidingScrollView!
    
    var cameFromProfile = false
    let datePicker = UIDatePicker()
    var userBirthdate: Date?
    let maritalStatusPicker = UIPickerView()
    let maritalStatuses = ["Solteiro(a)", "Relacionamento aberto", "Relacionamento sério", "Casado(a)", "Separado(a)", "Divorciado(a)", "Viúvo(a)"]
    
    var changedPhoto = false
    let validator = Validator()
    
    // MARK: Constructors
    
    init(cameFromProfile: Bool) {
        super.init(nibName: "PUEditProfileViewController", bundle: nil)
        self.cameFromProfile = cameFromProfile
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTextFields()
        setupValidator()
        setupPickers()
        setupCurrentUser()
    }
    
    // MARK: Setups
    
    func setupLayout() {
        self.userImageView.layer.cornerRadius = userImageView.layer.bounds.height/2
        self.userImageView.layer.masksToBounds = true
        self.concludeBtn.layer.cornerRadius = concludeBtn.frame.height/2

        let gesture = UITapGestureRecognizer(target: self, action: #selector(userImageViewTapped))
        gesture.numberOfTapsRequired = 1
        userImageView.isUserInteractionEnabled = true
        userImageView.addGestureRecognizer(gesture)
    }
    
    func setupTextFields() {
        for tf in [tfName, tfNickname, tfEmail, tfGender, tfMaritalStatus, tfBirthdate] {
            tf?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        }
    }
    
    func setupValidator() {
        validator.registerField(tfNickname, rules: [RequiredRule(), MinLengthRule(length: 9)])
        validator.registerField(tfBirthdate, rules: [RequiredRule()])
        validator.registerField(tfMaritalStatus, rules: [RequiredRule()])
    }
    
    func setupPickers() {
        maritalStatusPicker.dataSource = self
        maritalStatusPicker.delegate = self
        maritalStatusPicker.backgroundColor = .white
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        datePicker.datePickerMode = .date
        datePicker.locale = Locale.current
        datePicker.backgroundColor = .white
        datePicker.maximumDate = Date()
        
        tfBirthdate.inputView = datePicker
        tfMaritalStatus.inputView = maritalStatusPicker
    }
    
    func setupCurrentUser() {
        PUUser.current()?.picture?.fetchIfNeededInBackground(block: { (result, error) in
            if error == nil {
                PUUser.current()?.picture?.image.getDataInBackground(block: {
                    (data, error) in
                    if data != nil {
                        self.userImageView.image = UIImage(data: data!)
                    }
                })
            }
        })
        
        if let name = PUUser.current()?.name {
            self.tfName.text = name
            if !cameFromProfile {
                self.tfName.isEnabled = false
            }
        }
        
        if let email = PUUser.current()?.email {
            self.tfEmail.text = email
            if !cameFromProfile {
                self.tfEmail.isEnabled = false
            }
            
        }
        
        if let gender = PUUser.current()?.gender {
            if gender.lowercased() == "male" {
                self.tfGender.text = "Masculino"
            } else if gender.lowercased() == "female" {
                self.tfGender.text = "Feminino"
            } else {
                self.tfGender.text = "Outro"
            }
            
            if !cameFromProfile {
                self.tfGender.isEnabled = false
            }
            
        }
        
        if cameFromProfile {
            if let maritalStatus = PUUser.current()?.maritalStatus {
                self.tfMaritalStatus.text = maritalStatus
            }
            
            if let birthday = PUUser.current()?.birthdate {
                self.datePicker.date = birthday
                self.tfBirthdate.text = DateFormatter.localizedString(from: birthday, dateStyle: .medium, timeStyle: .none).folding(locale: Locale.current)
            }
            
            if let nickname = PUUser.current()?.nickname {
                self.tfNickname.text = nickname
            }
            
        }
    }
    
    // MARK: Selectors
    
    func textFieldDidChange(_ textField: UITextField) {
        self.validator.validate(self)
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        if sender.datePickerMode == .date {
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.timeStyle = DateFormatter.Style.none
        } else {
            dateFormatter.dateStyle = DateFormatter.Style.none
            dateFormatter.timeStyle = DateFormatter.Style.short
        }
        
        self.tfBirthdate.text = dateFormatter.string(from: sender.date).folding(locale: Locale.current)
        userBirthdate = sender.date
        validator.validate(self)
    }
    
    func userImageViewTapped() {
        var configuration = Configuration()
        configuration.cancelButtonTitle = "Cancelar"
        configuration.doneButtonTitle = "Concluir"
        configuration.noImagesTitle = "Nenhuma imagem selecionada."
        configuration.recordLocation = false
        
        let imagePickerController = ImagePickerController(configuration: configuration)
        imagePickerController.imageLimit = 1
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: Actions

    @IBAction func concludeBtnPressed(_ sender: Any) {
        if cameFromProfile {
            if PUUser.current()?.nickname != self.tfNickname.text {
                let query = PUUser.query()
                query?.whereKeyExists("nickname")
                query?.whereKey("nickname", equalTo: self.tfNickname.text!)
                query?.findObjectsInBackground(block: { (response, error) in
                    if response?.count != 0 {
                        self.tfNickname.errorMessage = "Por favor, escolha outro apelido."
                    } else {
                        
                        if self.changedPhoto {
                            let media = PUMedia()
                            let image = self.userImageView.image!
                            media.image = PFFile(name: "image.jpg", data: UIImageJPEGRepresentation(image, 0.6)!)
                            media.thumbnail = PFFile(name: "thumb.jpg", data: UIImageJPEGRepresentation(image, 0.9)!)
                            PUUser.current()?.picture = media
                        }
                        
                        PUUser.current()?.nickname = self.tfNickname.text
                        PUUser.current()?.birthdate = self.userBirthdate
                        PUUser.current()?.maritalStatus = self.tfMaritalStatus.text
                        PUUser.current()?.isOnARide = NSNumber(booleanLiteral: false)
                        PUUser.current()?.saveInBackground(block: { (success, error) in
                            if success {
                                self.navigationController?.popViewController(animated: true)
                            }
                        })
                    }
                })
            } else {
                
                if self.changedPhoto {
                    let media = PUMedia()
                    let image = self.userImageView.image!
                    media.image = PFFile(name: "image.jpg", data: UIImageJPEGRepresentation(image, 0.6)!)
                    media.thumbnail = PFFile(name: "thumb.jpg", data: UIImageJPEGRepresentation(image, 0.9)!)
                    PUUser.current()?.picture = media
                    
                    PUUser.current()?.nickname = self.tfNickname.text
                    PUUser.current()?.birthdate = self.userBirthdate
                    PUUser.current()?.maritalStatus = self.tfMaritalStatus.text
                    PUUser.current()?.isOnARide = NSNumber(booleanLiteral: false)
                    PUUser.current()?.saveInBackground(block: { (success, error) in
                        if success {
                            self.navigationController?.popViewController(animated: true)
                        } else {
                            print(error.debugDescription)
                        }
                    })
                    
                } else {
                    PUUser.current()?.nickname = self.tfNickname.text
                    PUUser.current()?.birthdate = self.userBirthdate
                    PUUser.current()?.maritalStatus = self.tfMaritalStatus.text
                    PUUser.current()?.isOnARide = NSNumber(booleanLiteral: false)
                    PUUser.current()?.saveInBackground(block: { (success, error) in
                        if success {
                            self.navigationController?.popViewController(animated: true)
                        } else {
                            print(error.debugDescription)
                        }
                    })
                }
            }
        } else {
            let query = PUUser.query()
            query?.whereKeyExists("nickname")
            query?.whereKey("nickname", equalTo: self.tfNickname.text!)
            query?.findObjectsInBackground(block: { (response, error) in
                if response?.count != 0 {
                    self.tfNickname.errorMessage = "Por favor, escolha outro apelido."
                } else {
                    PUUser.current()?.nickname = self.tfNickname.text
                    PUUser.current()?.birthdate = self.userBirthdate
                    PUUser.current()?.maritalStatus = self.tfMaritalStatus.text
                    PUUser.current()?.isOnARide = NSNumber(booleanLiteral: false)
                    PUUser.current()?.saveInBackground(block: { (success, error) in
                        if success {
                            let controller = PUMainViewController()
                            controller.title = "#PartiuUFAL"
                            PUNavigationManager.switchRootViewController(UINavigationController(rootViewController: controller), animated: true, completion: nil)
                        }
                    })
                }
            })
        }
    }
    
}

extension PUEditProfileViewController: ImagePickerDelegate {
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {

    }

    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }

    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true) { 
            self.userImageView.image = images[0]
            self.changedPhoto = true
        }
    }
}

extension PUEditProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maritalStatuses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return maritalStatuses[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.tfMaritalStatus.text = maritalStatuses[row]
        validator.validate(self)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension PUEditProfileViewController: ValidationDelegate {
    func validationSuccessful() {
        self.tfNickname.errorMessage = ""
        self.tfBirthdate.errorMessage = ""
        self.tfMaritalStatus.errorMessage = ""
        
        concludeBtn.alpha = 1
        concludeBtn.isEnabled = true
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        self.tfNickname.errorMessage = ""
        self.tfBirthdate.errorMessage = ""
        self.tfMaritalStatus.errorMessage = ""
        
        concludeBtn.alpha = 0.5
        concludeBtn.isEnabled = false
        
        for (field, _) in errors {
            if (field as! SkyFloatingLabelTextField) == self.tfNickname {
                if self.tfNickname.text == "" {
                    self.tfNickname.errorMessage = "Campo obrigatório."
                } else {
                    self.tfNickname.errorMessage = "O apelido deve ter no mínimo 9 caracteres."
                }
            }
            
            if (field as! SkyFloatingLabelTextField) == self.tfBirthdate {
                self.tfBirthdate.errorMessage = "Campo obrigatório."
            }
            
            if (field as! SkyFloatingLabelTextField) == self.tfMaritalStatus {
                self.tfMaritalStatus.errorMessage = "Campo obrigatório."
            }
        }
    }
}
