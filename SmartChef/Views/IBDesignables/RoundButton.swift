//
//  RoundButton.swift
//  SmartChef
//
//  Created by Student on 03.01.18.
//  Copyright © 2018 hskl. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    var e = UIViewPropertyAnimator()
    var alarmState: Bool = true
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        e = UIViewPropertyAnimator(duration: 1.3, curve: .easeInOut) {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        e.addCompletion{ _ in
            self.changeState(oldState: self.alarmState)
        }
        e.startAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        e.stopAnimation(true)
        self.shrinkButtonAgain()
    }
    
    func shrinkButtonAgain() {
        e = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut) {
            self.transform = CGAffineTransform.identity
        }
        e.addCompletion { _ in
            
        }
        e.startAnimation()
    }
    func changeState(oldState: Bool) {
        if oldState {
            self.backgroundColor = UIColor.darkGray
            self.imageView?.image = UIImage(named: "VolumeOff")
            alarmState = !alarmState
        } else {
            self.backgroundColor = UIColor.orange
            self.imageView?.image = UIImage(named: "VolumeOn")
            alarmState = !alarmState
        }
    }
    
}
