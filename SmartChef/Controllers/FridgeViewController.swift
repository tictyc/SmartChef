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
    
    @IBOutlet weak var autoOrdersSwitch: UISwitch!
    @IBOutlet weak var autoOrdersLabel: UILabel!
    
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
        fridge!.automatedOrders ? (autoOrdersSwitch.isOn = true) : (autoOrdersSwitch.isOn = false)
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
