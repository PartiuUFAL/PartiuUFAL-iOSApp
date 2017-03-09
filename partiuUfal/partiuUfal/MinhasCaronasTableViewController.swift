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
        
        if(Sistema.usuarioAtual == nil) {
            Sistema.usuarioAtual = CaronaDAO.getList()[0].motorista
        }
        print("+++++++++++++++++\(Sistema.usuarioAtual?.caronas.count)")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
