//
//  TouchesViewController.swift
//  
//
//  Created by Rubens Pessoa on 09/03/17.
//
//

import UIKit

class TouchesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
