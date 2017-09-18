//
//  PULoginInteractor.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 18/06/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation
import Parse
import ParseFacebookUtilsV4


protocol PULoginInteractorDelegate {
    func userDidLogin(user: PFUser?, error: Error?, newUser: Bool, data: NSDictionary?)
    func userDidLogout(error: Error?)
}

class PULoginInteractor {
    
    var delegate: PULoginInteractorDelegate?
    
    func facebookLogin() {
        PFFacebookUtils.facebookLoginManager().loginBehavior = FBSDKLoginBehavior.native
        PFFacebookUtils.logInInBackground(withReadPermissions: ["public_profile", "email", "user_birthday","user_location"]) {
            
            (user, error) in
            
            if let user = user {
                self.getFacebookUserInfoWithCompletion(completion: { (error, result) in
                    if result != nil {
                        self.delegate?.userDidLogin(user: user, error: nil, newUser: user.isNew, data: result!)
                    }else if let error = error {
                        self.delegate?.userDidLogin(user: nil, error: error, newUser: false, data: nil)
                    }
                    
                })
            } else {
                print(error.debugDescription)
            }
        }
    }
    
    private func getFacebookUserInfoWithCompletion(completion:@escaping (_ error:Error?,_ result:NSDictionary?) -> Void) {
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, email, picture.type(large), gender"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    completion(nil, result as? NSDictionary)
                }else {
                    completion(error, nil)
                }
            })
        }
    }
}
