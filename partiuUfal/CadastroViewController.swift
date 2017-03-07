//
//  CadastroViewController.swift
//  partiuUfal
//
//  Created by Student on 3/7/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

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
    
    @IBAction func switchModoMotorista(_ sender: Any) {
        motoristaStackView.isHidden = !modoMotoristaSwitch.isOn
    }
    @IBAction func addCarro() {
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
        novoUsuario = Usuario(nome: nome, sobrenome: sobrenome, cpf: cpf, matricula: matricula, email: email, senha: senha, telefone: telefone)
        
        //Enviar cadastro para o banco de dados
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        motoristaStackView.isHidden = false
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
