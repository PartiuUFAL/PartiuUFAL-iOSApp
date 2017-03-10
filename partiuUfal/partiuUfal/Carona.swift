//
//  Carona.swift
//  partiuUfal
//
//  Created by Student on 3/7/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation

class Carona {
    var id: UInt32 = 0
    var motorista: Usuario
    var passageiros: [Usuario] = []
    var voltando: Bool = false
    var saida: String
    var chegada: String
    var dataInicio: Data?
    var dataFim: Data?
    var inicio: Hora?
    var fim: Hora?
    var descricao: String
    var via: String
    var vagas: Int
    
    init(
        motorista: Usuario, voltando: Bool, saida: String,
        chegada: String, descricao: String, via: String, vagas: Int,
        dataInicio: Data?, dataFim: Data?, inicio: Hora?, fim: Hora?
        ) {
        self.id = arc4random();
        self.motorista = motorista
        self.voltando = voltando
        self.saida = saida
        self.chegada = chegada
        self.descricao = descricao
        self.via = via
        self.vagas = vagas
        self.dataInicio = dataInicio!
        self.dataFim = dataFim!
        self.inicio = inicio!
        self.fim = fim!
    }
    func addPassageiro(passageiro: Usuario) {
        self.passageiros.append(passageiro)
    }
}
    
class CaronaDAO {
        
    static func getList() -> [Carona] {
        
        var users: [Usuario] = UsuarioDAO.getList()
        
        var data1: Data = Data(dia: 11, mes: 11, ano: 2017)
        var data2: Data = Data(dia: 10, mes: 11, ano: 2017)
        var data3: Data = Data(dia: 2, mes: 3, ano: 2017)
        var data4: Data = Data(dia: 3, mes: 4, ano: 2017)
        
        var hora1: Hora = Hora(hora: 7,min: 0)
        var hora2: Hora = Hora(hora: 9,min: 0)
        var hora3: Hora = Hora(hora: 15,min: 0)
        var hora4: Hora = Hora(hora: 16,min: 30)
        
        let carona1 = Carona(motorista: users[0], voltando: true, saida: "UFAL" , chegada: "Jacintinho", descricao: "Carona: R$ 2,00", via: "Via expressa", vagas: 3, dataInicio: data3, dataFim: data1, inicio: hora1, fim: hora2)
        carona1.addPassageiro(passageiro: users[2])
        carona1.addPassageiro(passageiro: users[3])
        let carona2 = Carona(motorista: users[1], voltando: true, saida: "UFAL" ,
        chegada: "Ponta Verde", descricao: "Carona: R$ 4,00", via: "Via expressa", vagas: 2, dataInicio: data2, dataFim: data1, inicio: hora1, fim: hora2)
        carona2.addPassageiro(passageiro: users[0])
        let carona3 = Carona(motorista: users[0], voltando: true, saida: "UFAL" ,
                             chegada: "Praia do Francês", descricao: "Carona: R$ 7,00", via: "Fernandes Lima", vagas: 4, dataInicio: data3, dataFim: data1, inicio: hora1, fim: hora2)
        carona3.addPassageiro(passageiro: users[2])
        let carona4 = Carona(motorista: users[3], voltando: false, saida: "Benedito Bentes", chegada: "UFAL", descricao: "Carona: R$ 2,00", via: "Via expressa", vagas: 2, dataInicio: data3, dataFim: data2, inicio: hora1, fim: hora2)
        carona4.addPassageiro(passageiro: users[3])
        let carona5 = Carona(motorista: users[0], voltando: false, saida: "Jacintinho" , chegada: "UFAL", descricao: "Carona: R$ 2,00", via: "Via Expressa", vagas: 2, dataInicio: data3, dataFim: data1, inicio: hora1, fim: hora2)
        carona5.addPassageiro(passageiro: users[1])
        carona5.addPassageiro(passageiro: users[2])
        return [carona1, carona2, carona3, carona4, carona5]
    }
}
