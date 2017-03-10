//
//  Sistema.swift
//  partiuUfal
//
//  Created by Student on 3/7/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation

class Sistema {
    static var usuarios:[Usuario] = []
    static var caronas:[Carona] = []
    static var usuarioAtual:Usuario?
    static func initDB() {
        caronas = CaronaDAO.getList()
        usuarios = UsuarioDAO.getList()
    }
    static func login(email: String, senha: String) -> Usuario? {
        initDB()
        for _usuario in usuarios {
            if(_usuario.email == email) {
                if(_usuario.senha == senha) {
                    usuarioAtual = _usuario
                    return usuarioAtual
                }
            }
        }
        return nil
    }
    static func usuarioEhNulo() -> Bool {
        if usuarioAtual == nil {
            return true
        }
        return false
    }
}
