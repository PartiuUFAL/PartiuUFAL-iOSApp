//
//  CaronaDetalhesViewController.swift
//  
//
//  Created by Student on 3/9/17.
//
//

import UIKit

class CaronaDetalhesViewController: UIViewController {

    var caronaAtual: Carona?
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var saidaLabel: UILabel!
    @IBOutlet weak var chegadaLabel: UILabel!
    @IBOutlet weak var viaLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UITextView!
    @IBOutlet weak var vagasLabel: UILabel!
    @IBAction func pedirCarona() {
        if Sistema.usuarioAtual?.id == caronaAtual?.motorista.id {
            caronaAtual?.vagas -= 1
            caronaAtual?.addPassageiro(passageiro: Sistema.usuarioAtual!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nomeLabel.text = caronaAtual?.motorista.nome
        saidaLabel.text = caronaAtual?.saida
        chegadaLabel.text = caronaAtual?.chegada
        viaLabel.text = caronaAtual?.via
        descricaoLabel.text = caronaAtual?.descricao
        vagasLabel.text = "\(caronaAtual!.vagas)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
