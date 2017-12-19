//
//  CookingPotViewController.swift
//  SmartChef
//
//  Created by Student on 11.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

class CookingPotViewController: UIViewController {
    
    var pot : CookingPot?
    
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cookingPotImage: UIImageView!
    
    @IBAction func statusSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            pot?.status = true
            statusLabel.text = "Cooking Pot is on"
        } else {
            pot?.status = true
            statusLabel.text = "Cooking Pot is off"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cookingPotImage.image = pot?.image
        
        if pot?.status == true {
            statusSwitch.isOn = true
            statusLabel.text = "Cooking Pot is on"
        } else {
            statusSwitch.isOn = false
            statusLabel.text = "Cooking Pot is off"
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
