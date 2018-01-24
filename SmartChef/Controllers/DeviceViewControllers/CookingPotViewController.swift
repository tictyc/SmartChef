//
//  CookingPotViewController.swift
//  SmartChef
//
//  Created by Student on 11.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit
import UserNotifications

class CookingPotViewController: UIViewController {
    
    var pot : CookingPot?
    var timer = Timer()
    
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cookButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var heatstatusLabel: UILabel!
    @IBOutlet weak var timerPicker: UIPickerView!
    @IBOutlet weak var heatSlider: UISlider!
    @IBOutlet weak var remainingTime: UILabel!
    
    let onString = "Your Cooking Pot is on."
    let offString = "Your Cooking Pot is off."
    
    var seconds: Int = 0
    var minutes: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pot?.name
        
        timerPicker.dataSource = self
        timerPicker.delegate = self
        
        if pot?.status == true {
            statusSwitch.isOn = true
            statusLabel.text = onString
            toggleInteractionOn()
        } else {
            statusSwitch.isOn = false
            statusLabel.text = offString
            toggleInteractionOff()
        }
        loadBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadBarButtons()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func startCookingAction(_ sender: UIButton) {
        askForNotificationPermission()
        
        // Starts a timer for the microwaving process
        if seconds < 10 {
            remainingTime.text = "\(minutes):0\(seconds)"
        } else {
            remainingTime.text = "\(minutes):\(seconds)"
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (self.counter), userInfo: nil, repeats: true)
        showTimer()
    }
    
    @IBAction func cancelCookingAction(_ sender: UIButton) {
        timer.invalidate()
        exitTimer()
    }
    
    @IBAction func statusSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            pot?.status = true
            statusLabel.text = onString
            toggleInteractionOn()
        } else {
            pot?.status = true
            statusLabel.text = offString
            toggleInteractionOff()
            if timer.isValid {
                timer.invalidate()
            }
            exitTimer()
        }
    }
    
    @IBAction func heatSliderAction(_ sender: UISlider) {
        pot?.heat = sender.value
        PersistenceService.saveContext()
    }
    
    @objc func counter () {
        seconds -= 1

        if seconds <= 0 && minutes <= 0 {
            
            // if the timer is over, fire notifcation or alert depending on if the app is in background or not
            if UIApplication.shared.applicationState == .background {
                fireNotification(title: "\(pot?.name ?? "Cooking Pot")", body: "Your food is ready.")
            } else {
                fireAlert(title: "Your food processed in the \(pot?.name ?? "Microwave") is ready.", confirmationTitle: "Confirm")
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
        cancelButton.isHidden = true
        heatstatusLabel.isHidden = true
        
        timerPicker.isHidden = false
        cookButton.isHidden = false
    }
    
    func showTimer() {
        // UI state setup to show the timer
        timerPicker.isHidden = true
        cookButton.isHidden = true
        
        cancelButton.isHidden = false
        remainingTime.isHidden = false
        heatstatusLabel.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleInteractionOn (){
        heatSlider.isEnabled = true
        timerPicker.isUserInteractionEnabled = true
        cookButton.isEnabled = true
    }
    
    func toggleInteractionOff (){
        heatSlider.isEnabled = false
        timerPicker.isUserInteractionEnabled = false
        cookButton.isEnabled = false
    }
    
}

extension CookingPotViewController:UIPickerViewDelegate,UIPickerViewDataSource {
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
    
    
    // navigation item buttons, have not found a way to inherit those yet due to struggling with the selector engine, hence the un-dry code
    @objc func addToFavorites() {
        pot?.isFavorite = true
        PersistenceService.saveContext()
        loadBarButtons()
    }
    
    @objc func removeFromFavorites() {
        pot?.isFavorite = false
        PersistenceService.saveContext()
        loadBarButtons()
    }
    
    func loadBarButtons() {
        if pot?.isFavorite == false {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add to favorites", style: .plain, target: self, action: #selector(addToFavorites))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Remove from favorites", style: .plain, target: self, action: #selector(removeFromFavorites))
        }
    }
}

