//
//  Hora.swift
//  partiuUfal
//
//  Created by Rubens Pessoa on 09/03/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation

class Hora {
    var hora: Int
    var min: Int
    init(hora: Int, min: Int) {
        if(hora < 0 || hora > 24) {
            self.hora = 0
        }
        else {
            self.hora = hora
        }
        if(min < 0 || min > 60) {
            self.min = 0
        }
        else {
            self.min = min
        }
    }
}
