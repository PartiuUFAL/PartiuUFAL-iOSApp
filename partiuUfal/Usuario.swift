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
        _ nome: String, _ sobrenome: String, _ cpf: String, _ matricula: String,
        _ email: String, _ senha:String, _ telefone: String, _ carros: [Carro]
        ) {
        self.nome = nome
        self.sobrenome = sobrenome
        self.cpf = cpf
        self.matricula = matricula
        self.email = email
        self.senha = senha
        self.telefone = telefone
        self.carros = carros
    }
    
    
}
