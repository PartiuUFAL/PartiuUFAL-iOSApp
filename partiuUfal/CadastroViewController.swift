//
//  CadastroViewController.swift
//  partiuUfal
//
//  Created by Student on 3/7/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Firebase
import UIKit

class CadastroViewController: UIViewController {

    var novoUsuario: Usuario?
    var carros: [Carro] = []
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var sobrenomeTextField: UITextField!
    @IBOutlet weak var cpfTextField: UITextField!
    @IBOutlet weak var matriculaTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var modoMotoristaSwitch: UISwitch!
    @IBOutlet weak var telefoneTextField: UITextField!
    @IBOutlet weak var motoristaStackView: UIStackView!
    @IBOutlet weak var modeloTextField: UITextField!
    @IBOutlet weak var placaTextField: UITextField!
    @IBOutlet weak var corTextField: UITextField!
    
    @IBOutlet weak var switchModoMotorista: UISwitch!

    @IBOutlet weak var statusModoMotorista: UILabel!

    @IBAction func switchModoMotorista(_ sender: Any) {
        
        motoristaStackView.isHidden = !modoMotoristaSwitch.isOn
        
        if modoMotoristaSwitch.isOn {
            statusModoMotorista.text = "Ativado"
        } else {
            statusModoMotorista.text = "Desativado"
        }
        
    }
    
    @IBAction func addCarro(_ sender: Any) {
        let modelo = modeloTextField.text!
        let placa = placaTextField.text!
        let cor = corTextField.text!
        carros.append(Carro(modelo: modelo, placa: placa, cor: cor))
    }

    @IBAction func concluirCadastro() {
        let nome = nomeTextField.text!
        let sobrenome = sobrenomeTextField.text!
        let cpf = cpfTextField.text!
        let matricula = matriculaTextField.text!
        let email = emailTextField.text!
        let senha = senhaTextField.text!
        let telefone = telefoneTextField.text!
        novoUsuario = Usuario.init(nome, sobrenome, cpf, matricula, email, senha, telefone, self.carros)
        Sistema.usuarioAtual = novoUsuario
        //Enviar cadastro para o banco de dados
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("users").child(email).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            if value == nil {
        
                var firebaseList: NSArray = NSArray()                

                ref.child("users/\(email)/nome").setValue(nome)
                ref.child("users/\(email)/sobrenome").setValue(sobrenome)
                ref.child("users/\(email)/cpf").setValue(cpf)
                ref.child("users/\(email)/matricula").setValue(matricula)
                ref.child("users/\(email)/email").setValue(email)
                ref.child("users/\(email)/senha").setValue(senha)
                ref.child("users/\(email)/telefone").setValue(telefone)
                //ref.child("users/\(["carros"])").setValue(firebaseList)
           }
            
            }) { (error) in
                print(error.localizedDescription)
            }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motoristaStackView.isHidden = !modoMotoristaSwitch.isOn
        
        if(!Sistema.usuarioEhNulo()) {
            let auxUsuario = Sistema.usuarioAtual!
            nomeTextField.text = auxUsuario.nome
            sobrenomeTextField.text = auxUsuario.sobrenome
            cpfTextField.text = auxUsuario.cpf
            matriculaTextField.text = auxUsuario.matricula
            emailTextField.text = auxUsuario.email
            modoMotoristaSwitch.isOn = (auxUsuario.carros.count > 0)
            telefoneTextField.text = auxUsuario.telefone
        }
        // Do any additional setup after loading the view.
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
