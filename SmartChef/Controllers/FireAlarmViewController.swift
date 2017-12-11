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
    
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var fireAlarmImage: UIImageView!
    
    @IBAction func statusSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            fireAlarm?.setStatus(newStatus: true)
            statusLabel.text = "Fire Alarm is on"
        } else {
            fireAlarm?.setStatus(newStatus: false)
            statusLabel.text = "Fire Alarm is off"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fireAlarmImage.image = fireAlarm?.image
        
        if fireAlarm?.status == true {
            statusSwitch.isOn = true
            statusLabel.text = "Fire Alarm is on"
        } else {
            statusSwitch.isOn = false
            statusLabel.text = "Fire Alarm is off"
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
