//
//  Device+CoreDataProperties.swift
//  SmartChef
//
//  Created by Student on 22.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//
//

import Foundation
import CoreData


extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var status: Bool

}
