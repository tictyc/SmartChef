//
//  Fridge.swift
//  SmartChef
//
//  Created by Student on 10.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

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
