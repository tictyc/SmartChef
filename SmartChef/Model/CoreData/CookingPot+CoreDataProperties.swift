//
//  CookingPot+CoreDataProperties.swift
//  SmartChef
//
//  Created by Student on 22.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//
//

import Foundation
import CoreData


extension CookingPot {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CookingPot> {
        return NSFetchRequest<CookingPot>(entityName: "CookingPot")
    }

    @NSManaged public var heat: Int16

}
