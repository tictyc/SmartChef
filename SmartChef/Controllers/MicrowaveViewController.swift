//
//  MicrowaveViewController.swift
//  SmartChef
//
//  Created by Student on 08.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit
import UserNotifications

class MicrowaveViewController: UIViewController {
    
    var microwave : Microwave?
    var timer = Timer()
    
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var microwaveModeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var timerPicker: UIPickerView!
    @IBOutlet weak var microwaveButton: UIButton!
    @IBOutlet weak var remainingTime: UILabel!
    @IBOutlet weak var cancelTimerButton: UIButton!
    @IBOutlet weak var heatingLabel: UILabel!
    
    
    let onString = "Your Microwave is on."
    let offString = "Your Microwave is off."
    
    var minutes: Int = 0
    var seconds: Int = 0

    
    @IBAction func startMicrowavingAction(_ sender: UIButton) {
        
        // Ask for permission to deliver notifications
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        
        // Starts a timer for the microwaving process
        if seconds < 10 {
            remainingTime.text = "\(minutes):0\(seconds)"
        } else {
            remainingTime.text = "\(minutes):\(seconds)"
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (self.counter), userInfo: nil, repeats: true)
        showTimer()
    }
    
    @objc func counter () {
        seconds -= 1
        
        if seconds <= 0 && minutes <= 0 {
            
            // if the timer is over, fire notifcation or alert depending on if the app is in background or not
            if UIApplication.shared.applicationState == .background {
                fireNotification(title: "\(microwave?.name ?? "Microwave")", body: "Your food is ready.")
            } else {
                fireAlert(title: "Your food processed in the \(microwave?.name ?? "Microwave") is ready.", confirmationTitle: "Confirm")
            }
            
            timer.invalidate()
            exitTimer()
            return
        }
        
        if seconds < 10 {
            remainingTime.text = "\(minutes):0\(seconds)"
        } else {
            remainingTime.text = "\(minutes):\(seconds)"
        }
        
        if seconds == 0 {
            minutes -= 1
            seconds = 60
        }
    }
    
    func exitTimer() {
        // resets class variables to match timerPicker values and resets UI State
        minutes = timerPicker.selectedRow(inComponent: 0)
        seconds = timerPicker.selectedRow(inComponent: 1)
        
        remainingTime.isHidden = true
        cancelTimerButton.isHidden = true
        heatingLabel.isHidden = true
        
        timerPicker.isHidden = false
        microwaveButton.isHidden = false
    }
    
    @IBAction func cancelTimerAction(_ sender: UIButton) {
        timer.invalidate()
        exitTimer()
    }
    
    @IBAction func statusSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            microwave?.status = true
            statusLabel.text = onString
            toggleInteractionOn()
        } else {
            microwave?.status = false
            statusLabel.text = offString
            toggleInteractionOff()
            if timer.isValid {
                timer.invalidate()
            }
            exitTimer()
        }
        PersistenceService.saveContext()
    }
    
    @IBAction func microwaveModeSegControlAction(_ sender: UISegmentedControl) {
        // changes the microwave setting depending on selectedSegmentIndex and then persists the changes
        switch sender.selectedSegmentIndex {
        case 0:
            microwave?.mode = "Microwave"
        case 1:
            microwave?.mode = "Grilling"
        case 2:
            microwave?.mode = "Convection"
        default:
            print("Non-Existing Index: \(sender.selectedSegmentIndex) selected, something went wrong.")
        }
        PersistenceService.saveContext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = microwave?.name
        
        timerPicker.delegate = self
        timerPicker.dataSource = self
        
        // UI Setup based on Microwave status
        if microwave?.status == true {
            statusSwitch.isOn = true
            statusLabel.text = onString
            toggleInteractionOn()
            if timer.isValid {
                showTimer()
            }
        } else {
            statusSwitch.isOn = false
            statusLabel.text = offString
            toggleInteractionOff()
        }
        
        // Pre-select the SegmentedControl Segment
        switch microwave?.mode {
        case "Microwave"?:
            microwaveModeSegmentedControl.selectedSegmentIndex = 0
        case "Grilling"?:
            microwaveModeSegmentedControl.selectedSegmentIndex = 1
        case "Convection"?:
            microwaveModeSegmentedControl.selectedSegmentIndex = 2
        default:
            print("Illegal value for microwave.mode: \(microwave?.mode ?? "nil")")
        }
    }
    
    func showTimer() {
        // UI state setup to show the timer
        timerPicker.isHidden = true
        microwaveButton.isHidden = true
        
        cancelTimerButton.isHidden = false
        remainingTime.isHidden = false
        heatingLabel.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleInteractionOn (){
        microwaveModeSegmentedControl.isEnabled = true
        timerPicker.isUserInteractionEnabled = true
        microwaveButton.isEnabled = true
    }
    
    func toggleInteractionOff (){
        microwaveModeSegmentedControl.isEnabled = false
        timerPicker.isUserInteractionEnabled = false
        microwaveButton.isEnabled = false
    }
    
}
extension MicrowaveViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            minutes = row
        case 1:
            seconds = row
        default:
            break;
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        // Shows white-colored strings in both components while considering singular and plural
        switch component {
        case 0:
            if row == 1 {
                return NSAttributedString(string: "\(row) Minute", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
            } else {
                return NSAttributedString(string: "\(row) Minutes", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
            }
        case 1:
            if row == 1 {
                return NSAttributedString(string: "\(row) Second", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
            } else {
                return NSAttributedString(string: "\(row) Seconds", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
            }
        default:
            return NSAttributedString(string: "\(row) Seconds", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        }
    }
}

