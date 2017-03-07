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
    
    
    init(
        motorista: Usuario, voltando: Bool, saida: String,
        chegada: String, descricao: String, via: String
        ) {
        self.motorista = motorista
        self.voltando = voltando
        self.saida = saida
        self.chegada = chegada
        self.descricao = descricao
        self.via = via
    }
    
}
