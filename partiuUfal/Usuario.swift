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
    
    init(nome: String, sobrenome: String, cpf: String, matricula: String, email: String, senha:String, telefone: String) {
        self.nome = nome
        self.sobrenome = sobrenome
        self.cpf = cpf
        self.matricula = matricula
        self.email = email
        self.senha = senha
        self.telefone = telefone
    }
    
    func addCar(car: Carro) {
        self.carros.append(car)
    }
}

class UsuarioDAO {
    
    static func getList() -> [Usuario] {
        
        var carrosCriados: [Carro] = CarroDAO.getList()
        
        var user1: Usuario = Usuario(nome: "Crodoaldo", sobrenome: "da Silva", cpf: "02934839822039", matricula: "23", email: "sdjwpe@ohsfoiw.cow", senha: "109230293", telefone: "99999-9999")
        
        var user2: Usuario = Usuario(nome: "Abigobaldo", sobrenome: "da Cunha", cpf: "02934839822038", matricula: "24", email: "sdjwpf@ohsfoiw.cow", senha: "109230294", telefone: "99999-9990")
        
        user1.addCar(car: carrosCriados[0])
        user1.addCar(car: carrosCriados[1])
        user2.addCar(car: carrosCriados[1])
        
        return [user1, user2]
    }
}
