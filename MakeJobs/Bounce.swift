//
//  Bounce.swift
//  MakeJobs
//
//  Created by Nikhil on 5/17/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit

class Bounce: UIButton {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        super.touchesBegan(touches, with: event)
    }

}
