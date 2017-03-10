//
//  CadastroViewController.swift
//  partiuUfal
//
//  Created by Student on 3/7/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Firebase
import UIKit

class CadastroViewController: TouchesViewController {

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
        modeloTextField.text = ""
        placaTextField.text = ""
        corTextField.text = ""
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
        novoUsuario?.carros = carros
        Sistema.usuarioAtual = novoUsuario
        Sistema.usuarios.append(novoUsuario!)
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
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

