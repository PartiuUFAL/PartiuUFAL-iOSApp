//
//  Carro.swift
//  partiuUfal
//
//  Created by Student on 3/7/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation

class Carro {
    
    var id: UInt32 = 0
    var modelo: String
    var placa: String
    var cor: String
    
    init(modelo: String, placa: String, cor: String) {
        self.id = arc4random();
        self.modelo = modelo
        self.placa = placa
        self.cor = cor
    }
}

class CarroDAO {
    static func getList() -> [Carro] {
        return [
            Carro(modelo: "GM Celta", placa:"NME-2601", cor: "Preto"),
            Carro(modelo: "Nissan Match", placa: "Nehoir", cor: "Vermelho")
        ]
    }
}

