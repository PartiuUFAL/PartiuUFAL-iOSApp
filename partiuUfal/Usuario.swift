//
//  Usuario.swift
//  partiuUfal
//
//  Created by Student on 3/7/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation

class Usuario {
    
    var id: UInt32 = 0
    var carros: [Carro] = []
    var caronas: [Carona] = []
    var nome: String = ""
    var sobrenome: String = ""
    var cpf: String = ""
    var matricula: String = ""
    var email: String = ""
    var senha: String = ""
    var telefone: String = ""
    
    init(nome: String, sobrenome: String, cpf: String, matricula: String, email: String, senha:String, telefone: String) {
        self.id = arc4random();
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
    
    func addCarona(carona: Carona) {
        self.caronas.append(carona)
    }
}

class UsuarioDAO {
    static func getList() -> [Usuario] {
        var car1: Carro = Carro(modelo: "GM Celta", placa: "JSJ-9900", cor: "Preto")
        var car2: Carro = Carro(modelo: "Ford Ka", placa: "NMS-0000", cor: "Cinza")
        var car3: Carro = Carro(modelo: "GM Cruze Mary Kay", placa: "UHU-L0k4", cor: "Magenta")
        var car4: Carro = Carro(modelo: "Ford New Fiest", placa: "OHB-5915", cor: "Verde limão")
        
        let user1 = Usuario(nome: "Rubens", sobrenome: "Pessoa de Barros Filho", cpf: "098866541-00",
                            matricula: "14151627", email: "rpbf@ic.ufal.br", senha: "a123456", telefone: "82-9999-9999" )
            user1.addCar(car: car1)
            user1.addCar(car: car2)
        let user2 = Usuario(nome: "Alysson", sobrenome: "Macedo", cpf: "989584723-20",
                    matricula: "14126327", email: "alysson@ic.ufal.br", senha: "b123456", telefone: "82-9998-9999" )
        user2.addCar(car: car4)
        let user3 = Usuario(nome: "Beroaldo", sobrenome: "da Cunha", cpf: "123584723-20",
                    matricula: "33336327", email: "aberoaldo@icachaça.ufal.br", senha: "b123456", telefone: "82-9998-9992" )
        let user4 = Usuario(nome: "Beroaldo Miguelense", sobrenome: "dos Anjos", cpf: "123584233-11",
                    matricula: "32236327", email: "beroaldo@ic.ufal.br", senha: "c123456", telefone: "82-9998-9991" )
        let user5 = Usuario(nome: "Pablo", sobrenome: "Hijito de tu Mamita", cpf: "987789987-09", matricula: "12341234", email: "pablito@escobar.col", senha: "d123456", telefone: "52-00-2666-3434")
        user5.addCar(car: car3)
        return [user1,user2,user3,user4,user5]
    }
}
