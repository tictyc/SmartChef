//
//  DeviceLine.swift
//  SmartChef
//
//  Created by Student on 01.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//


var myCoffeeMachine = CoffeeMachine(strength: 50, milkStatus: true, coffeeBeansStatus: true, type: CoffeeType.Coffee)
var myFridge = Fridge(temperature: 3.0, automatedOrders: false)
var myMicroWave = MicroWave(watt: MicrowaveWatt.A, mode: MicrowaveMode.Microwaving, timer: 0.0)
var myFireAlarm = FireAlarm(alertTriggered: false, cookingMode: false)
var myCookingPot = CookingPot(heat: CookingPotHeat.middle)

let devices: [Device] = [myCoffeeMachine, myFridge, myMicroWave, myFireAlarm, myCookingPot]

