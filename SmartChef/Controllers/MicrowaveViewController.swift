//
//  MicrowaveViewController.swift
//  SmartChef
//
//  Created by Student on 08.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

class MicrowaveViewController: UIViewController {
    
    var microwave : Microwave?
    
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var countdownPicker: UIDatePicker!
    @IBOutlet weak var microwaveModeSegmentedControl: UISegmentedControl!
    
    let onString = "Your Microwave is on."
    let offString = "Your Microwave is off."
    
    @IBAction func statusSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            microwave?.status = true
            statusLabel.text = onString
        } else {
            microwave?.status = false
            statusLabel.text = offString
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = microwave?.name
        
        
        if microwave?.status == true {
            statusSwitch.isOn = true
            statusLabel.text = onString
            toggleInteractionOn()
        } else {
            statusSwitch.isOn = false
            statusLabel.text = offString
            toggleInteractionOff()
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleInteractionOn (){
        microwaveModeSegmentedControl.isEnabled = true
    }
    
    func toggleInteractionOff (){
        microwaveModeSegmentedControl.isEnabled = false
    }
    
}

