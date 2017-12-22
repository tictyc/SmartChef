//
//  Fridge+CoreDataProperties.swift
//  SmartChef
//
//  Created by Student on 22.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//
//

import Foundation
import CoreData


extension Fridge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fridge> {
        return NSFetchRequest<Fridge>(entityName: "Fridge")
    }

    @NSManaged public var temperature: Double
    @NSManaged public var automatedOrders: Bool

}
