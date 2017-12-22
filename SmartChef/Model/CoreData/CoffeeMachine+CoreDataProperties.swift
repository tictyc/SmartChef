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

    @NSManaged public var coffeeBeansLevel: Int16
    @NSManaged public var coffeeType: String?
    @NSManaged public var milkLevel: Int16
    @NSManaged public var strength: Int16
    @NSManaged public var relationship: Device?

}
