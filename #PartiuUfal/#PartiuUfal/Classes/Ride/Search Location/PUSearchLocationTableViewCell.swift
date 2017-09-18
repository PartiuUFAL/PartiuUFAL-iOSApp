//
//  PUSearchLocationTableViewCell.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 31/07/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit

class PUSearchLocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbLocationName: UILabel!
    @IBOutlet weak var lbLocationAddress: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(locationNamed: String, address: String) {
        lbLocationName.text = locationNamed
        lbLocationAddress.text = address
    }
    
}
