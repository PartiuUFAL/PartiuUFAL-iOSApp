//
//  Sistema.swift
//  partiuUfal
//
//  Created by Student on 3/7/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation

class Sistema {
    static var usuarioAtual: Usuario? = nil
    static func usuarioEhNulo() -> Bool {
        if usuarioAtual == nil {
            return true
        }
        return false
    }
}
