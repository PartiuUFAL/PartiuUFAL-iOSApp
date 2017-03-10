//
//  MinhasCaronasTableViewController.swift
//  partiuUfal
//
//  Created by Vanessa Chata Soares Vieira on 07/03/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit

class MinhasCaronasTableViewController: UITableViewController {
    
    var data = [
        ("Caronas oferecidas",[String]()),
        ("Caronas solicitadas",[String]())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        data[1].1 = []
        data[0].1 = []
        
        for carona in CaronaDAO.getList() {
            
            var prefixo = "[VOLTANDO]"
            var endereco = "UFAL - \(carona.chegada)"
            if carona.chegada == "UFAL" {
                prefixo = "[INDO]"
                endereco = "\(carona.saida) - UFAL"
            }
            
            if(carona.motorista.cpf != Sistema.usuarioAtual?.cpf) {
                data[1].1.append("\(prefixo) \(endereco)")
            }
        }
        for carona in (Sistema.usuarioAtual?.caronas)! {
            var prefixo = "[VOLTANDO]"
            var endereco = "UFAL - \(carona.chegada)"
            if carona.chegada == "UFAL" {
                prefixo = "[INDO]"
                endereco = "\(carona.saida) - UFAL"
            }
            
            data[0].1.append("\(prefixo) \(endereco)")
        }
        tableView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[section].1.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.data[section].0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "caronaOferecidaIdentifier", for: indexPath)
        
        let seção = data[indexPath.section].1
        let filme = seção[indexPath.row]
        
        cell.textLabel?.text = filme

        return cell
    }
}
