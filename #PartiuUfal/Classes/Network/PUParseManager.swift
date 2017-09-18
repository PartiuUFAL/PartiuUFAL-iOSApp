//
//  PUParseManager.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 08/07/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//


import Foundation
import Parse
import UIKit

class PUParseManager {
    
    enum ParseInstance {
        case local
        case staging
        case develop
        case production
    }
    
    static let parseInstance: ParseInstance = .develop
    
    static func setupParse() {
        var parseConfiguration: ParseClientConfiguration!
        
        switch PUParseManager.parseInstance {
        case .local:
            break
        case .staging:
//            parseConfiguration = ParseClientConfiguration(block: { configuration in
//                configuration.isLocalDatastoreEnabled = true
//                configuration.applicationId = "A4T5X5ytPZqZC7KVBudUnvyBnnXE8Z5PbSpXxNZj"
//                configuration.clientKey = "3ektQKcFBwHBFcmVrUfZmgQ9w3tWGHBag2KmnTWd"
//                configuration.server = "https://rubenspessoa.me/partiuufal-staging"
//            })
            break
        case .develop:
            parseConfiguration = ParseClientConfiguration(block: { configuration in
                configuration.isLocalDatastoreEnabled = true
                configuration.applicationId = "VzlR9tgGaw2O2hAjlcI7FpT0s1XtwXIbcxaqbV75"
                configuration.clientKey = "dMFgwumTW6052dxi6lCjL4lKXkpDTGbigkBLhbNg"
                configuration.server = "https://parseapi.back4app.com/"
            })
            break
        case .production:
//            parseConfiguration = ParseClientConfiguration(block: { configuration in
//                configuration.isLocalDatastoreEnabled = true
//                configuration.applicationId = "VtBWyYprFsJB3aUYf7Ts4N4nheMgF5ydnZLxAYMR"
//                configuration.clientKey = "4USLBBqFBWhknGSSwc6asdv3AHzHRdVwKESb68tx"
//                configuration.server = "https://rubenspessoa.me/partiuufal"
//            })
            break
        }
        Parse.initialize(with: parseConfiguration)
    }
    
    static func getErrorDescription(forCode code: Int?) -> String {
        guard let code = code else {
            return "Um erro desconhecido aconteceu. Por favor, tente mais tarde"
        }
        switch code {
        case 100:
            return "Não foi possível conectar-se com o servidor"
        case 101:
            return "Seu nome de usuário ou senha estão incorretos"
        case 125:
            return "Seu endereço de email não é válido"
        case 200:
            return "É necessário digitar seu nome de usuário"
        case 201:
            return "É necessário digitar a senha"
        case 202:
            return "Este nome de usuário já está sendo usado"
        case 203:
            return "Este email já está sendo usado"
        default:
            return "Um erro desconhecido aconteceu. Por favor, tente mais tarde"
        }
    }
}
