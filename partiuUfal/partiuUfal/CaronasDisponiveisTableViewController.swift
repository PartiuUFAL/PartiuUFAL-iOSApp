//
//  CaronasDisponiveisTableViewController.swift
//  partiuUfal
//
//  Created by Student on 3/9/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit

class CaronasDisponiveisTableViewController: UITableViewController {

    var caronasAtual: [Carona] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for carona in CaronaDAO.getList() {
                if(carona.motorista.cpf != Sistema.usuarioAtual?.cpf) {
                    caronasAtual.append(carona)
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.caronasAtual.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "caronaOferecidaIdentifier", for: indexPath)

        if let caronaCell = cell as? CaronasDisponiveisTableViewCell {
            let carona = self.caronasAtual[indexPath.row]
            var prefixo = "[VOLTANDO]"
            var endereco = carona.chegada
            if carona.chegada == "UFAL" {
                prefixo = "[INDO]"
                endereco = carona.saida
            }
            caronaCell.enderecoLabel.text = "\(prefixo) \(endereco)"
            caronaCell.nomeLabel.text = carona.motorista.nome
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex = tableView.indexPathForSelectedRow?.row
        let carona = self.caronasAtual[selectedIndex!]
        
        if segue.identifier == "caronaDetalhesIdentifier" {
            if let caronaDetalhesNewView = segue.destination as? CaronaDetalhesViewController {
                caronaDetalhesNewView.caronaAtual = carona
            }
        }
    }
}
