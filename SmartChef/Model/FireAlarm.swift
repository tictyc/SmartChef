//
//  FireAlarm.swift
//  SmartChef
//
//  Created by Student on 10.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

class FireAlarm: Device {
    var alertTriggered: Bool
    var cookingMode: Bool
    init(alertTriggered: Bool, cookingMode: Bool) {
        self.alertTriggered = alertTriggered
        self.cookingMode = cookingMode
        super.init(name: "Fire Alarm", image: "FireAlarm", status: true)
    }
    func setAlertTriggered(newAlertTriggered: Bool) {
        alertTriggered = newAlertTriggered
    }
    func setCookingMode(newCookingMode: Bool) {
        cookingMode = newCookingMode
    }
}
