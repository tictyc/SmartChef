//
//  DeviceLine.swift
//  SmartChef
//
//  Created by Student on 01.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//


var devices : [Device]?

func initializeDevices() -> [Device]{
    let myCoffeeMachine = CoffeeMachine(context: PersistenceService.context)
    myCoffeeMachine.name = "Coffee Machine"
    myCoffeeMachine.image = "CoffeeMachine"
    myCoffeeMachine.status = false
    myCoffeeMachine.milkLevel = 100
    myCoffeeMachine.coffeeBeansLevel = 7.0
    myCoffeeMachine.waterLevel = 100
    myCoffeeMachine.coffeeType = 0
    myCoffeeMachine.strength = 0.5
    
    let myMicrowave = Microwave(context: PersistenceService.context)
    myMicrowave.name = "Microwave"
    myMicrowave.image = "Microwave"
    myMicrowave.status = false
    myMicrowave.mode = "Microwave"
    myMicrowave.timer = 10.0
    
    let myFireAlarm = FireAlarm(context: PersistenceService.context)
    myFireAlarm.name = "Fire Alarm"
    myFireAlarm.image = "FireAlarm"
    myFireAlarm.status = true
    myFireAlarm.alertTriggered = false
    myFireAlarm.cookingMode = false
    
    let myFridge = Fridge(context: PersistenceService.context)
    myFridge.name = "Fridge"
    myFridge.image = "Fridge"
    myFridge.status = true
    myFridge.temperature = 4.0
    myFridge.automatedOrders = false
    
    let myCookingPot = CookingPot(context: PersistenceService.context)
    myCookingPot.name = "Cooking Pot"
    myCookingPot.image = "CookingPot"
    myCookingPot.status = false
    myCookingPot.heat = 60
    
    PersistenceService.saveContext()
    let devices: [Device] = [myCoffeeMachine, myFridge, myMicrowave, myFireAlarm, myCookingPot]
    return devices
}


