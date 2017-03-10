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
    @IBOutlet weak var diaInicioTextField: UITextField!
    @IBOutlet weak var mesInicioTextField: UITextField!
    @IBOutlet weak var anoInicioTextField: UITextField!
    @IBOutlet weak var mesTerminoTextField: UITextField!
    @IBOutlet weak var diaTerminoTextField: UITextField!
    @IBOutlet weak var anoTerminoTextField: UITextField!
    @IBOutlet weak var horaInicioTextField: UITextField!
    @IBOutlet weak var minutoInicioTextField: UITextField!
    @IBOutlet weak var horaTerminoTextField: UITextField!
    @IBOutlet weak var minutoTerminoTextField: UITextField!
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
        let dataInicio = Data(
            dia: Int(diaInicioTextField.text!)!,
            mes: Int(mesInicioTextField.text!)!,
            ano: Int(anoInicioTextField.text!)!
        )
        let dataTermino = Data(
            dia: Int(diaTerminoTextField.text!)!,
            mes: Int(mesTerminoTextField.text!)!,
            ano: Int(anoTerminoTextField.text!)!
        )
        let horaInicio = Hora (
            hora: Int(horaInicioTextField.text!)!,
            min: Int(minutoInicioTextField.text!)!
        )
        let horaTermino = Hora (
            hora: Int(horaTerminoTextField.text!)!,
            min: Int(minutoTerminoTextField.text!)!
        )
        let carona = Carona(motorista: usuarioAtual, voltando: voltando, saida: saida, chegada: chegada, descricao: descricao, via: via, vagas: vagas, dataInicio: dataInicio, dataFim: dataTermino, inicio: horaInicio, fim: horaTermino)
        
        diaInicioTextField.text = ""
        mesInicioTextField.text = ""
        anoInicioTextField.text = ""
        mesTerminoTextField.text = ""
        diaTerminoTextField.text = ""
        anoTerminoTextField.text = ""
        horaInicioTextField.text = ""
        minutoInicioTextField.text = ""
        horaTerminoTextField.text = ""
        minutoTerminoTextField.text = ""
        
        usuarioAtual.addCarona(carona: carona)
        Sistema.caronas.append(carona)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        descricaoTextView.layer.borderWidth = 0.7
        descricaoTextView.layer.borderColor = UIColor.init(colorLiteralRed: 0.90, green: 0.90, blue: 0.90, alpha: 1).cgColor
        descricaoTextView.layer.cornerRadius = 6
        chegadaTextField.text = "UFAL"
        chegadaTextField.isEnabled = false
        vagasLabel.text = "\(Int(vagasSlider.value))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
