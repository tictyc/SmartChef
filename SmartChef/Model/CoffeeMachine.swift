//
//  CoffeeMachine.swift
//  SmartChef
//
//  Created by Student on 10.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

enum CoffeeType: String {
    case Coffee
    case Milkcoffee
    case Cappuccino
    case LatteMacchiato = "Latte Macchiato"
    case Espresso
}

let pickerCoffeeDataArray = [
    CoffeeType.Coffee.rawValue,
    CoffeeType.Milkcoffee.rawValue,
    CoffeeType.Cappuccino.rawValue,
    CoffeeType.LatteMacchiato.rawValue,
    CoffeeType.Espresso.rawValue
]

class CoffeeMachine: Device {
    var strength: Int
    var milkStatus: Bool
    var coffeeBeansStatus: Bool
    var coffeeCounter : Int
    var coffeeType: CoffeeType
    
    init(strength: Int, milkStatus: Bool, coffeeBeansStatus: Bool, type: CoffeeType) {
        self.strength = strength
        self.milkStatus = milkStatus
        self.coffeeBeansStatus = coffeeBeansStatus
        self.coffeeCounter = 0
        self.coffeeType = type
        super.init(name: "Coffee Machine", image: "CoffeeMachine", status: false)
    }
}
