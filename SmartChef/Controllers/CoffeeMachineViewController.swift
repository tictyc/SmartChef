//
//  CoffeeMachineViewController.swift
//  SmartChef
//
//  Created by Student on 08.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

class CoffeeMachineViewController: UIViewController {

    @IBOutlet weak var cmImage: UIImageView!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var brewButton: UIButton!
    @IBOutlet weak var brewProgress: UIProgressView!
    
    
    @IBAction func statusSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            coffeeMachine?.setStatus(newStatus: true)
            statusLabel.text = "Coffee Machine is on"
        } else {
            coffeeMachine?.setStatus(newStatus: false)
            statusLabel.text = "Coffee Machine is off"
            }
    }
    
    @IBAction func brewButtonPressed(_ sender: Any) {
        brewProgress.isHidden = false
        
        
        coffeeMachine?.coffeeCounter += 1
    }
    
    var coffeeMachine : CoffeeMachine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cmImage.image = coffeeMachine?.image
        
        if coffeeMachine?.status == true {
            statusSwitch.isOn = true
            statusLabel.text = "Coffee Machine is on"
        } else {
            statusSwitch.isOn = false
            statusLabel.text = "Coffee Machine is off"
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
