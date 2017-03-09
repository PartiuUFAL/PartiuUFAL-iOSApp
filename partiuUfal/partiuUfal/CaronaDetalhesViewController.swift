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
        //Verificar se é igual ao motorista
        //if Sistema.usuariaoAtual == caronaAtual.motorista? {}
        caronaAtual?.vagas -= 1
        caronaAtual?.addPassageiro(passageiro: Sistema.usuarioAtual!)
        print("_________________________\(caronaAtual!.passageiros.count)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nomeLabel.text = caronaAtual?.motorista.nome
        saidaLabel.text = caronaAtual?.saida
        chegadaLabel.text = caronaAtual?.chegada
        viaLabel.text = caronaAtual?.via
        descricaoLabel.text = caronaAtual?.descricao
        vagasLabel.text = "\(caronaAtual!.vagas)"
        
        if(Sistema.usuarioAtual == nil) {
            Sistema.usuarioAtual = CaronaDAO.getList()[0].motorista
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
