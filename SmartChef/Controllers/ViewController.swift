//
//  ViewController.swift
//  SmartChef
//
//  Created by Student on 30.11.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension UIViewController {
    
    func fireAlert(title: String, confirmationTitle: String) {
        // convenience function to fire alerts
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: confirmationTitle, style: .default, handler: nil)
        alert.addAction(confirm)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func fireNotification(title: String, body: String) {
        // convenience function to fire notifications
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func askForNotificationPermission () {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
    }
}


extension String {
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension DeviceTableViewController {
    
    func createDeviceAlert(alert: UIAlertController ,title: String, viewController: DeviceTableViewController) {
        alert.addAction(UIAlertAction(title: title, style: .default, handler: {(action) in
            // alert that allows user to create a new device
            
            let name = alert.textFields?.first!.text!
            if (name?.isBlank)! {
                viewController.showEmptyNameAlert(viewController: self)
            } else {
                let device : Device
                switch title {
                    // create new device with the entered name and chosen type
                    case "Coffee Machine": device = CoffeeMachine(context: PersistenceService.context)
                    case "Fridge": device = Fridge(context: PersistenceService.context)
                    case "Microwave": device = Microwave(context: PersistenceService.context)
                    case "Fire Alarm": device = FireAlarm(context: PersistenceService.context)
                    case "Cooking Pot": device = CookingPot(context: PersistenceService.context)
                default:
                    print("something went wrong in the createDeviceAlert() switch")
                    device = CoffeeMachine(context: PersistenceService.context)
                }
                viewController.createNewDevice(name: name!, device: device)
            }
        }))
    }
    
    func showEmptyNameAlert(viewController: DeviceTableViewController) {
        // notify the user of failed device creation due to an empty name
        
        let emptyStringAlert = UIAlertController(title: "Adding a new device has failed", message: "Please enter a name for your new device.", preferredStyle: .alert)
        emptyStringAlert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {
            (action) in
            viewController.plusButtonPressed(emptyStringAlert)
        }))
        self.present(emptyStringAlert, animated: true, completion: nil)
    }
}

