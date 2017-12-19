//
//  MicrowaveViewController.swift
//  SmartChef
//
//  Created by Student on 08.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

class MicrowaveViewController: UIViewController {

    var microwave : MicroWave?
    
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var microWaveImage: UIImageView!
    
    let onString = "Your Microwave is on."
    let offString = "Your Microwave is off."
    
    @IBAction func statusSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            microwave?.status = true
            statusLabel.text = onString
        } else {
            microwave?.status = true
            statusLabel.text = offString
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        microWaveImage.image = microwave?.image
        
        if microwave?.status == true {
            statusSwitch.isOn = true
            statusLabel.text = onString
        } else {
            statusSwitch.isOn = false
            statusLabel.text = offString
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
