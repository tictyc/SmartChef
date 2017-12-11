//
//  CoffeeMachine.swift
//  SmartChef
//
//  Created by Student on 10.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

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
    func setMilkStatus(newMilkStatus: Bool) {
        milkStatus = newMilkStatus
    }
    func setCoffeeBeansStatus(newCoffeeBeansStatus: Bool) {
        coffeeBeansStatus = newCoffeeBeansStatus
    }
}
