//
//  PUNavigationManager.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 30/08/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation
import UIKit

class PUNavigationManager {
    static func switchRootViewController(_ rootViewController: UIViewController, animated: Bool,
                                         transition: UIViewAnimationOptions = .transitionFlipFromLeft,
                                         completion: (() -> Void)?) {
        let window = UIApplication.shared.keyWindow
        if animated {
            UIView.transition(with: window!, duration: 0.5, options: transition, animations: {
                let oldState: Bool = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                window!.rootViewController = rootViewController
                UIView.setAnimationsEnabled(oldState)
            }, completion: { finished in
                if completion != nil {
                    completion!()
                }
            })
        } else {
            window!.rootViewController = rootViewController
        }
    }
}
