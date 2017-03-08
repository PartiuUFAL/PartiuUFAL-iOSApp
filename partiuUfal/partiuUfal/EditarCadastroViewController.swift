//
//  EditarCadastroViewController.swift
//  partiuUfal
//
//  Created by Student on 3/8/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit

class EditarCadastroViewController: UIViewController, UITableViewDataSource {

    var usuarioAtual: Usuario?
    @IBOutlet weak var carrosTableView: UITableView!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var sobrenomeLabel: UILabel!
    @IBOutlet weak var cpfLabel: UILabel!
    @IBOutlet weak var matriculaLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telefoneLabel: UILabel!
    @IBOutlet weak var modoMotoristaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usuarioAtual = Sistema.usuarioAtual
        carrosTableView.dataSource = self
        
        nomeLabel.text = usuarioAtual?.nome
        sobrenomeLabel.text = usuarioAtual?.sobrenome
        cpfLabel.text = usuarioAtual?.cpf
        matriculaLabel.text = usuarioAtual?.matricula
        telefoneLabel.text = usuarioAtual?.telefone
        if (usuarioAtual?.carros.count)! > 0 {
            modoMotoristaLabel.text = "Ativado"
        } else {
            modoMotoristaLabel.text = "Desativado"
            carrosTableView.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editarCadastro(_ sender: Any) {
        print("EITA PORRA!!")
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(self.usuarioAtual!.carros.count)
        return self.usuarioAtual!.carros.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarIdentifier", for: indexPath)
        
        // Configure the cell...
        if let carroCell = cell as? CarroTableViewCell {
            
            let carro = self.usuarioAtual?.carros[indexPath.row]
            
            carroCell.modeloLabel.text = carro?.modelo
            carroCell.placaLabel.text = carro?.placa
            carroCell.corLabel.text = carro?.cor
            print("\(carro)++++++++++++++++++++++++++++")
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.usuarioAtual!.carros.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
