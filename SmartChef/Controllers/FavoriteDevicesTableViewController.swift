//
//  FavoriteDevicesTableViewController.swift
//  SmartChef
//
//  Created by Student on 04.01.18.
//  Copyright © 2018 hskl. All rights reserved.
//

import UIKit
import CoreData

class FavoriteDevicesTableViewController: DeviceTableViewController {
    
    var favoriteDevices : [Device] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFavorites()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteDevices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as! DeviceTableViewCell
        let device = favoriteDevices[indexPath.row]
        cell.device = device
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.fetchDevices()
        fetchFavorites()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = favoriteDevices[indexPath.row]
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
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < favoriteDevices.count
        {
            // Ask user for verification of the delete process
            let alert = UIAlertController(title: "Are you sure you want to delete \(favoriteDevices[indexPath.row].name ?? "the device")?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: {(action) in
                
                // if confirmed: delete the device from the context
                let device = self.favoriteDevices[indexPath.row] as NSManagedObject
                PersistenceService.context.delete(device)
                
                // delete the device from the data source array favoriteDevices, then delete the corresponding tableView row
                self.favoriteDevices.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            
                // save the context and tell DeviceTableViewController to refresh its data source
                PersistenceService.saveContext()
                super.fetchDevices()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func fetchFavorites() {
        let fetchRequest : NSFetchRequest<Device> = Device.fetchRequest()
        do {
            let devices = try PersistenceService.context.fetch(fetchRequest)
            var newFavorites: [Device] = []
            for device in devices {
                if device.isFavorite == true {
                    newFavorites.append(device)
                }
            }
            self.favoriteDevices = newFavorites
            self.tableView.reloadData()
            print("favorites: \(self.favoriteDevices.count)")
        } catch {
            print("Fetch Request failed.")
        }
    }

}
