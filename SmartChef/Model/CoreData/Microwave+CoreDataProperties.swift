//
//  Microwave+CoreDataProperties.swift
//  SmartChef
//
//  Created by Student on 22.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//
//

import Foundation
import CoreData


extension Microwave {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Microwave> {
        return NSFetchRequest<Microwave>(entityName: "Microwave")
    }

    @NSManaged public var watt: Int16
    @NSManaged public var mode: String?
    @NSManaged public var timer: Double

}
