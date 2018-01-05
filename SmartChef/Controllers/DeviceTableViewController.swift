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
    
    var devices : [Device] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDevices()
    }
    
    func fetchDevices () {
        let fetchRequest : NSFetchRequest<Device> = Device.fetchRequest()
        do {
            let devices = try PersistenceService.context.fetch(fetchRequest)
            self.devices = devices
            DispatchQueue.main.async {
                print("devices: \(self.devices.count)")
                self.tableView.reloadData()
            }
        } catch {
            print("Fetch Request failed.")
        }
    }

    
    @IBAction func plusButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add a new device", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Device Name"
        }
        
        createDeviceAlert(alert: alert, title: "Coffee Machine", viewController: self)
        createDeviceAlert(alert: alert, title: "Microwave", viewController: self)
        createDeviceAlert(alert: alert, title: "Fire Alarm", viewController: self)
        createDeviceAlert(alert: alert, title: "Fridge", viewController: self)
        createDeviceAlert(alert: alert, title: "Cooking Pot", viewController: self)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            action in
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func persistNewDevice(newDevice: Device) {
        self.devices.append(newDevice)
        PersistenceService.saveContext()
        self.tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < devices.count
        {
            let alert = UIAlertController(title: "Are you sure you want to delete \(devices[indexPath.row].name ?? "the device")?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: {(action) in
                let device = self.devices[indexPath.row]
                PersistenceService.context.delete(device)
                self.devices.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                PersistenceService.saveContext()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.fetchDevices()
    }
    
}
