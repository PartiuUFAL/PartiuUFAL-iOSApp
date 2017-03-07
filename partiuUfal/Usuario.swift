//
//  Usuario.swift
//  partiuUfal
//
//  Created by Student on 3/7/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation

class Usuario {
    
    var carros: [Carro] = []
    var nome: String = ""
    var sobrenome: String = ""
    var cpf: String = ""
    var matricula: String = ""
    var email: String = ""
    var senha: String = ""
    var telefone: String = ""
    
    init(
        nome: String,sobrenome: String, cpf: String, matricula: String,
        email: String, senha:String, telefone: String
        ) {
        self.nome = nome
        self.sobrenome = sobrenome
        self.cpf = cpf
        self.matricula = matricula
        self.email = email
        self.senha = senha
        self.telefone = telefone
    }
    
    
}
