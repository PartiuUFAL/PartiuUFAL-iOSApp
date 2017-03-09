//
//  LogInViewController.swift
//  partiuUfal
//
//  Created by Student on 3/7/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        /*
        let email = emailTextField.text!
        
        print(email)
        let pass = senhaTextField.text!
        print(pass)
        //Validar com o banco de Dados
        
       
        let ref = FIRDatabase.database().reference()
        
        
        ref.child(email).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            if value != nil {
                let email = value?["email"] as! String
                let cpf = value?["cpf"] as! String
                let nome = value?["nome"] as! String
                let sobrenome = value?["sobrenome"] as! String
                let senha = value?["senha"] as! String
                let matricula = value?["matricula"] as! String
                let telefone = value?["telefone"] as! String
                // let carros = value?["carros"] as! [Carro]
                
                if(senha != pass){
                    /*
                     Notificar que esta diferente
                    */
                    
                    return
                }
                
                let user = Usuario.init(nome: nome, sobrenome:sobrenome, cpf: cpf, matricula: matricula, email: email, senha: senha, telefone: telefone)
                
                //print(cpf)
                /*
                 Passar dados pro banco local
                 */

            } else {
                print("nil")
                /*
                    Exibir msg de dados errados
                 */
            }
           
        }) { (error) in
            print(error.localizedDescription)
        } */
        
       /*
        
        //let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child("users").child(email).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
            
            let value = snapshot.value as? NSDictionary
            
            print(value)
            
                      // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        ref.child("users/(user.uid)/username").setValue(email)
 */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
