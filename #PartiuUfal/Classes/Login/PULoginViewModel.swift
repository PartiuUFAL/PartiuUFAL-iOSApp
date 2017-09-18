//
//  PULoginViewModel.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 18/06/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation
 import Parse

protocol PULoginInteractorRouterDelegate {
    func routeToNextScreen(newUser: Bool)
    func showWarning()
}

class PULoginViewModel {
    
    let loginInteractor = PULoginInteractor()
    var delegate: PULoginInteractorRouterDelegate?
    
    init() {
        loginInteractor.delegate = self
    }
    
    func login() {
        loginInteractor.facebookLogin()
    }
    
}

extension PULoginViewModel: PULoginInteractorDelegate {
    func userDidLogin(user: PFUser?, error:Error?, newUser:Bool, data: NSDictionary?) {
        
        if let error = error {
            print(error.localizedDescription)
        } else if user != nil {
            if newUser {
                extractFBUserDataFromDictionary(user: PUUser.current()!, data: data!)
            }
            PUUser.current()?.fetchIfNeededInBackground()
            delegate?.routeToNextScreen(newUser: newUser)
        } else {
            print("user cancel operation")
        }
    }
    
    func userDidLogout(error: Error?) {
        delegate?.showWarning()
    }
    
    private func extractFBUserDataFromDictionary(user: PUUser, data:NSDictionary) {
        
        if let imageDict = data["picture"] as? [String: Any] {
            let media = PUMedia()
            let imageDict1 = imageDict["data"] as! [String: Any]
            let imageURL = imageDict1["url"] as! String
            let imageData = NSData(contentsOf: URL(string: imageURL)!)
            let image = UIImage(data: imageData! as Data)
            media.image = PFFile(name: "image.jpg", data: UIImageJPEGRepresentation(image!, 0.6)!)
            media.thumbnail = PFFile(name: "thumb.jpg", data: UIImageJPEGRepresentation(image!, 0.9)!)
            user.picture = media
        }
        
        if let name = data["name"] as? String {
            user.name = name
        }
        
        if let email = data["email"] as? String {
            user.email = email
        }
        
        if let gender = data["gender"] as? String {
            user.gender = gender
        }
        
        user.saveInBackground { (success, error) in
            if success {
                print("Dados do usuário salvos com sucesso!")
            } else {
                print(error?.localizedDescription ?? "Erro ao salvar dados do usuário.")
            }
        }
    }
}
