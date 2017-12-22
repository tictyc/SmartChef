//
//  FireAlarm+CoreDataProperties.swift
//  SmartChef
//
//  Created by Student on 22.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//
//

import Foundation
import CoreData


extension FireAlarm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FireAlarm> {
        return NSFetchRequest<FireAlarm>(entityName: "FireAlarm")
    }

    @NSManaged public var alertTriggered: Bool
    @NSManaged public var cookingMode: Bool

}
