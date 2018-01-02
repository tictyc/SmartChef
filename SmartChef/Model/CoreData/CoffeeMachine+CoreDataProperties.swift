//
//  CoffeeMachine+CoreDataProperties.swift
//  SmartChef
//
//  Created by Student on 22.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//
//

import Foundation
import CoreData


extension CoffeeMachine {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoffeeMachine> {
        return NSFetchRequest<CoffeeMachine>(entityName: "CoffeeMachine")
    }
    
    @NSManaged public var coffeeBeansLevel: Float
    @NSManaged public var coffeeType: Int16
    @NSManaged public var milkLevel: Int16
    @NSManaged public var waterLevel: Int16
    @NSManaged public var strength: Float
    @NSManaged public var relationship: Device?
    
    var milk : Int {
        get { return Int(milkLevel) }
        set { milkLevel = Int16(newValue) }
    }
    
    var water: Int {
        get { return Int(waterLevel) }
        set { waterLevel = Int16(newValue) }
    }
    
}


