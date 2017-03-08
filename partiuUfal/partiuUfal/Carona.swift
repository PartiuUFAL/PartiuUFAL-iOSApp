//
//  Carona.swift
//  partiuUfal
//
//  Created by Student on 3/7/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation

class Carona {

    var motorista: Usuario
    var passageiros: [Usuario] = []
    var voltando: Bool = false
    var saida: String
    var chegada: String
    var descricao: String
    var via: String
    var vagas: Int
    
    
    init(
        motorista: Usuario, voltando: Bool, saida: String,
        chegada: String, descricao: String, via: String, vagas: Int
        ) {
        self.motorista = motorista
        self.voltando = voltando
        self.saida = saida
        self.chegada = chegada
        self.descricao = descricao
        self.via = via
        self.vagas = vagas
    }
    func addPassageiro(passageiro: Usuario) {
        self.passageiros.append(passageiro)
    }
}
    
class CaronaDAO {
        
    static func getList() -> [Carona] {
        let listUsers: [Usuario] = UsuarioDAO.getList()
            
        let carona1: Carona = Carona(motorista: listUsers[0], voltando: true, saida: "Ponta Verde", chegada: "Ponta Verde", descricao: "Carona paga. Valor: 2 reais", via: "Via Expressa", vagas: 4)
            
        let carona2: Carona = Carona(motorista: listUsers[1], voltando: true, saida: "Ponta Verde", chegada: "Ponta Verde", descricao: "Carona paga. Valor: 2 reais", via: "Via Expressa", vagas: 2)
            
        carona2.addPassageiro(passageiro: listUsers[0])
            
        return [carona1, carona2]
    }
}
