//
//  LogInViewController.swift
//  partiuUfal
//
//  Created by Student on 3/7/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit

class LogInViewController: TouchesViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var usuarioNaoEncontradoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: Any) {
        let email = emailTextField.text!
        let pass = senhaTextField.text!
        let usuario = Sistema.login(email: email, senha: pass)
        if(usuario != nil) {
            self.performSegue(withIdentifier: "loginSucessIdentifier", sender: self)
        } else {
            usuarioNaoEncontradoLabel.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
