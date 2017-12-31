//
//  FridgeViewController.swift
//  SmartChef
//
//  Created by Student on 08.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

class FridgeViewController: UIViewController {
    
    var fridge : Fridge?
    
    
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var autoOrdersSwitch: UISwitch!
    @IBOutlet weak var autoOrdersLabel: UILabel!
    
    let onString = "Your Fridge is on."
    let offString = "Your Fridge is off."
    
    
    @IBAction func statusSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            fridge?.status = true
            statusLabel.text = onString
        } else {
            fridge?.status = false
            statusLabel.text = offString
        }
        PersistenceService.saveContext()
    }
    
    @IBAction func autoOrdersAction(_ sender: UISwitch) {
        if sender.isOn {
            fridge?.automatedOrders = true
        } else {
            fridge?.automatedOrders = false
        }
        PersistenceService.saveContext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = fridge?.name
        
        if fridge?.status == true {
            statusSwitch.isOn = true
            statusLabel.text = onString
            toggleInteractionOn()
        } else {
            statusSwitch.isOn = false
            statusLabel.text = offString
            toggleInteractionOff()
        }
        
        if fridge?.automatedOrders == true {
            autoOrdersSwitch.isOn = true
        } else {
            autoOrdersSwitch.isOn = false
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func toggleInteractionOn () {
        autoOrdersLabel.isEnabled = true
        autoOrdersSwitch.isEnabled = true
    }
    
    func toggleInteractionOff () {
        autoOrdersLabel.isEnabled = false
        autoOrdersSwitch.isEnabled = false
    }
    
}
