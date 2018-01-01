//
//  DeviceTableViewController.swift
//  SmartChef
//
//  Created by Student on 01.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit
import CoreData

class DeviceTableViewController: UITableViewController {
    
    var devices : [Device]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest : NSFetchRequest<Device> = Device.fetchRequest()
        
        do {
            let devices = try PersistenceService.context.fetch(fetchRequest)
            self.devices = devices
            self.tableView.reloadData()
        } catch {
            print("Fetch Request failed.")
        }
        
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add a new device", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Device Name"
        }
        
        alert.addAction(UIAlertAction(title: "Coffee Machine", style: .default, handler: {(action) in
            let name = alert.textFields?.first!.text!
            if (name?.isBlank)! {
                self.showEmptyNameAlert()
            } else {
                let device = CoffeeMachine(context: PersistenceService.context)
                self.createNewDevice(name: name!, device: device)
            }
        }))
        alert.addAction(UIAlertAction(title: "Fire Alarm", style: .default, handler: {(action) in
            let name = alert.textFields?.first!.text!
            if (name?.isBlank)! {
                self.showEmptyNameAlert()
            } else {
                let device = FireAlarm(context: PersistenceService.context)
                self.createNewDevice(name: name!, device: device)
            }
        }))
        alert.addAction(UIAlertAction(title: "Fridge", style: .default, handler: {(action) in
            let name = alert.textFields?.first!.text!
            if (name?.isBlank)! {
                self.showEmptyNameAlert()
            } else {
                let device = Fridge(context: PersistenceService.context)
                self.createNewDevice(name: name!, device: device)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Microwave", style: .default, handler: {(action) in
            let name = alert.textFields?.first!.text!
            if (name?.isBlank)! {
                self.showEmptyNameAlert()
            } else {
                let device = Microwave(context: PersistenceService.context)
                self.createNewDevice(name: name!, device: device)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cooking Pot", style: .default, handler: {(action) in
            let name = alert.textFields?.first!.text!
            if (name?.isBlank)! {
                self.showEmptyNameAlert()
            } else {
                let device = CookingPot(context: PersistenceService.context)
                self.createNewDevice(name: name!, device: device)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in
            print("Cancel")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func persistNewDevice(newDevice: Device) {
        PersistenceService.saveContext()
        self.devices.append(newDevice)
        self.tableView.reloadData()
    }
    
    func showEmptyNameAlert() {
        let emptyStringAlert = UIAlertController(title: "Please enter a name for your new device!", message: nil, preferredStyle: .alert)
        emptyStringAlert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {
            (action) in
            self.plusButtonPressed(emptyStringAlert)
        }))
        self.present(emptyStringAlert, animated: true, completion: nil)
    }
    
    func createNewDevice(name: String, device: Device) {
        switch device {
        case device as CoffeeMachine:
            device.image = "CoffeeMachine"
        case device as Fridge:
            device.image = "Fridge"
        case device as Microwave:
            device.image = "Microwave"
        case device as CookingPot:
            device.image = "CookingPot"
        case device as FireAlarm:
            device.image = "FireAlarm"
        default:
            print("error: device type does not exist")
        }
        device.name = name
        
        persistNewDevice(newDevice: device)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as! DeviceTableViewCell
        let device = devices[indexPath.row]
        cell.device = device
        
        return cell
    }
    
    // UITableViewDelegate
    
    var selectedDevice : Device?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = devices[indexPath.row]
        
        if device is FireAlarm {
            selectedDevice = device as! FireAlarm
            performSegue(withIdentifier: "ShowFireAlarmDetail", sender: nil)
        }
        else if device is CoffeeMachine {
            selectedDevice = device as! CoffeeMachine
            performSegue(withIdentifier: "ShowCoffeeMachineDetail", sender: nil)
        } else if device is Fridge {
            selectedDevice = device as! Fridge
            performSegue(withIdentifier: "ShowFridgeDetail", sender: nil)
        } else if device is Microwave {
            selectedDevice = device as! Microwave
            performSegue(withIdentifier: "ShowMicrowaveDetail", sender: nil)
        } else if device is CookingPot {
            selectedDevice = device as! CookingPot
            performSegue(withIdentifier: "ShowCookingPotDetail", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCoffeeMachineDetail" {
            let deviceDetailVC = segue.destination as! CoffeeMachineViewController
            deviceDetailVC.coffeeMachine = selectedDevice as? CoffeeMachine
        } else if segue.identifier == "ShowMicrowaveDetail" {
            let deviceDetailVC = segue.destination as! MicrowaveViewController
            deviceDetailVC.microwave = selectedDevice as? Microwave
        } else if segue.identifier == "ShowFridgeDetail" {
            let deviceDetailVC = segue.destination as! FridgeViewController
            deviceDetailVC.fridge = selectedDevice as? Fridge
        } else if segue.identifier == "ShowFireAlarmDetail" {
            let deviceDetailVC = segue.destination as! FireAlarmViewController
            deviceDetailVC.fireAlarm = selectedDevice as? FireAlarm
        } else if segue.identifier == "ShowCookingPotDetail" {
            let deviceDetailVC = segue.destination as! CookingPotViewController
            deviceDetailVC.pot = selectedDevice as? CookingPot
        }
    }
}

extension String {
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
