//
//  UIButton.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 30/08/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setBackgroundColor(to: UIColor, animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.2) {
                self.backgroundColor = to
            }
        } else {
            self.backgroundColor = to
        }
    }
}
