//
//  Devices.swift
//  SmartChef
//
//  Created by Student on 01.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

class Device {
    var name: String
    var image: UIImage
    var status: Bool
    
    init(name: String, image: String, status: Bool) {
        self.name = name
        self.status = status
        if let image = UIImage(named: image) {
            self.image = image
        } else {
            self.image = UIImage(named: "default")!
        }
    }
    func setStatus (newStatus: Bool) {
        status = newStatus
    }
    func getStatus () -> Bool {
        return status
    }
    func getName () -> String {
        return name
    }
}

class CoffeeMachine: Device {
    var strength: Int
    var milkStatus: Bool
    var coffeeBeansStatus: Bool
    
    init(strength: Int, milkStatus: Bool, coffeeBeansStatus: Bool) {
        self.strength = strength
        self.milkStatus = milkStatus
        self.coffeeBeansStatus = coffeeBeansStatus
        super.init(name: "Coffee Machine", image: "CoffeeMachine", status: false)
    }
    func setStrength(newStrength: Int) {
        var tmpStrength = newStrength
        if newStrength > 100 {
            tmpStrength = 100
        }
        strength = tmpStrength
    }
    func getStrength() -> Int {
        return strength
    }
    func setMilkStatus(newMilkStatus: Bool) {
        milkStatus = newMilkStatus
    }
    func getMilkStatus() -> Bool {
        return milkStatus
    }
    func setCoffeeBeansStatus(newCoffeeBeansStatus: Bool) {
        coffeeBeansStatus = newCoffeeBeansStatus
    }
    func getCoffeeBeansStatus() -> Bool {
        return coffeeBeansStatus
    }
}

enum MicrowaveWatt: UInt {
    case A = 400
    case B = 600
    case C = 800
    case D = 1000
}

enum MicrowaveMode {
    case Grilling
    case Microwaving
    case Convection
}

class MicroWave: Device {
    var watt: MicrowaveWatt
    var mode: MicrowaveMode
    var timer: Double
    init(watt: MicrowaveWatt, mode: MicrowaveMode, timer: Double) {
        self.watt = watt
        self.mode = mode
        self.timer = timer
        super.init(name: "Microwave", image: "Microwave", status: false)
    }
    func setWatt(newWatt:MicrowaveWatt) {
        watt = newWatt
    }
    func getWatt() -> MicrowaveWatt {
        return watt
    }
    func setMode(newMode:MicrowaveMode) {
        mode = newMode
    }
    func getMode() -> MicrowaveMode {
        return mode
    }
    func setTimer(newTime:Double) {
        timer = newTime
    }
    func getTimer() -> Double {
        return timer
    }
}

class Fridge: Device {
    var temperature: Double
    var automatedOrders: Bool
    init(temperature: Double, automatedOrders: Bool) {
        self.temperature = temperature
        self.automatedOrders = automatedOrders
        super.init(name: "Fridge", image: "Fridge", status: true)
    }
    func setTemperature(newTemperature: Double) {
        var tmpTemperature = newTemperature
        if tmpTemperature > 10.0 {
            tmpTemperature = 10.0
        } else if tmpTemperature < -5.0 {
            tmpTemperature = -5.0
        }
        temperature = tmpTemperature
    }
    func getTemperature() -> Double {
        return temperature
    }
    func setAutomatedOrders(newAutomatedOrders: Bool) {
        automatedOrders = newAutomatedOrders
    }
}

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
    func getAlertTriggered() -> Bool {
        return alertTriggered
    }
    func setCookingMode(newCookingMode: Bool) {
        cookingMode = newCookingMode
    }
    func getCookingMode() -> Bool {
        return cookingMode
    }
}
