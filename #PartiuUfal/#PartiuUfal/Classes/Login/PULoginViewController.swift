//
//  PULoginViewController.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 18/06/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit
import Parse

class PULoginViewController: UIViewController {

    @IBOutlet weak var emailLogin: UIButton!
    @IBOutlet weak var facebookLogin: UIButton!
    
    let loginViewModel = PULoginViewModel()
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    // MARK: Actions
    
    @IBAction func btFacebookLoginTapped(_ sender: Any) {
        loginViewModel.login()
        
    }
    
    // MARK: Setup View
    
    func setupLayout() {
        self.facebookLogin.layer.cornerRadius = self.facebookLogin.frame.height/2
        loginViewModel.delegate = self
    }
}

extension PULoginViewController: PULoginInteractorRouterDelegate {
    func routeToNextScreen(newUser: Bool) {
        if newUser {
            let controller = PUEditProfileViewController(cameFromProfile: false)
            controller.title = "Concluir Cadastro"
            PUNavigationManager.switchRootViewController(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        } else {
            let controller = PUMainViewController()
            controller.title = "#partiuUFAL"
            PUNavigationManager.switchRootViewController(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        }
    }
    
    func showWarning() {
        let alert = UIAlertController(title: "Ops!", message: "Ocorreu algum problema enquanto registrávamos você aos nossos servidores. Por favor, tente novamente.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
