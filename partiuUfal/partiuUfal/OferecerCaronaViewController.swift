//
//  OferecerCaronaViewController.swift
//  partiuUfal
//
//  Created by Student on 3/8/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit

class OferecerCaronaViewController: TouchesViewController {

    @IBOutlet weak var indoSegmentedControl: UISegmentedControl!
    @IBOutlet weak var saidaTextField: UITextField!
    @IBOutlet weak var chegadaTextField: UITextField!
    @IBOutlet weak var viaTextField: UITextField!
    @IBOutlet weak var descricaoTextView: UITextView!
    @IBOutlet weak var vagasLabel: UILabel!
    @IBOutlet weak var vagasSlider: UISlider!
    @IBAction func trocarDirecao() {
        if(indoSegmentedControl.selectedSegmentIndex == 0) {
            chegadaTextField.text = "UFAL"
            chegadaTextField.isEnabled = false
            saidaTextField.text = ""
            saidaTextField.isEnabled = true
        }
        else if(indoSegmentedControl.selectedSegmentIndex == 1) {
            saidaTextField.text = "UFAL"
            saidaTextField.isEnabled = false
            chegadaTextField.text = ""
            chegadaTextField.isEnabled = true
        }
    }
    @IBAction func vagasMudou() {
        var sliderValue = 0.0;
        sliderValue = Double(lroundf(vagasSlider.value));
        vagasSlider.setValue(Float(sliderValue), animated: true)
        vagasLabel.text = "\(Int(vagasSlider.value))"
    }
    @IBAction func oferecerCarona() {
        let saida = saidaTextField.text!
        let chegada = chegadaTextField.text!
        let via = viaTextField.text!
        let descricao = descricaoTextView.text!
        let vagas = Int(vagasSlider.value)
        let usuarioAtual = Sistema.usuarioAtual!
        let voltando = (indoSegmentedControl.selectedSegmentIndex == 0)
        let carona = Carona(motorista: usuarioAtual, voltando: voltando, saida: saida, chegada: chegada, descricao: descricao, via: via, vagas: vagas)
        usuarioAtual.addCarona(carona: carona)
        //Enviar para o firebase a carona
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(Sistema.usuarioAtual == nil) {
            Sistema.usuarioAtual = CaronaDAO.getList()[0].motorista
        }
        descricaoTextView.layer.borderWidth = 0.7
        descricaoTextView.layer.borderColor = UIColor.init(colorLiteralRed: 0.90, green: 0.90, blue: 0.90, alpha: 1).cgColor
        descricaoTextView.layer.cornerRadius = 6
        chegadaTextField.text = "UFAL"
        chegadaTextField.isEnabled = false
        vagasLabel.text = "\(Int(vagasSlider.value))"
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
