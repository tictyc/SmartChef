//
//  FireAlarmViewController.swift
//  SmartChef
//
//  Created by Student on 08.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

class FireAlarmViewController: UIViewController {
    
    var fireAlarm : FireAlarm?
    var timer = Timer()
    var fireAlarmDeactivationCounter: Int = 60 * 30
    @IBOutlet weak var silenceStatusText: UILabel!
    @IBOutlet weak var silenceButton: RoundButton!
    
    let onString = "Your alarm is active. Press and hold to silence your alarm for 30 minutes."
    let offString = "Your alarm is silenced. Press and hold to unsilence your alarm again."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = fireAlarm?.name
        
        if silenceButton.alarmState {
            silenceStatusText.text = onString
        } else {
            silenceStatusText.text = offString
        }
        
        // initialize gesture recognizer for long press
        let holdAndSilence = UILongPressGestureRecognizer(target: self, action: #selector(silenceFireAlarm(sender:)))
        holdAndSilence.minimumPressDuration = 1.2
        silenceButton.addGestureRecognizer(holdAndSilence)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func silenceFireAlarm(sender: UIGestureRecognizer) {
        
        if sender.state == .ended {
            // if button was pressed long enough, shrink button again and switch modes of the fire alarm
            
            fireAlarm?.cookingMode = true
            silenceButton.shrinkButtonAgain()
            
            if silenceButton.alarmState {
                timer.invalidate()
                fireAlarmDeactivationCounter = 30 * 60
                silenceStatusText.text = onString
            } else {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (self.counter), userInfo: nil, repeats: true)
                silenceStatusText.text = offString
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func counter() {
        fireAlarmDeactivationCounter -= 1
        
        if fireAlarmDeactivationCounter == 0 {
            // resets timer & resets states to unsilenced fire alarm again
            
            fireAlarm?.cookingMode = false
            timer.invalidate()
            silenceButton.changeState(oldState: false)
            silenceStatusText.text = onString
            fireAlarmDeactivationCounter = 30 * 60
        }
    }
    
}

