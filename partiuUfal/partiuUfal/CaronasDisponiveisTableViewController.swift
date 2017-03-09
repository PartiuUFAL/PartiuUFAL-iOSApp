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
        if(Sistema.usuarioAtual == nil) {
            Sistema.usuarioAtual = CaronaDAO.getList()[0].motorista
        }
        print("+++++++++++++++++\(Sistema.usuarioAtual?.caronas.count)")
        
        for carona in CaronaDAO.getList() {
                if(carona.motorista.cpf != Sistema.usuarioAtual?.cpf) {
                    caronasAtual.append(carona)
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let selectedIndex = tableView.indexPathForSelectedRow?.row
        let carona = self.caronasAtual[selectedIndex!]
        
        if segue.identifier == "caronaDetalhesIdentifier" {
            if let caronaDetalhesNewView = segue.destination as? CaronaDetalhesViewController {
                caronaDetalhesNewView.caronaAtual = carona
            }
        }
    }
}