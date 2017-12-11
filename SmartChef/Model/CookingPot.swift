//
//  CookingPot.swift
//  SmartChef
//
//  Created by Student on 11.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

enum CookingPotHeat {
    case low
    case middle
    case high
}

class CookingPot: Device {
    var heat: CookingPotHeat
    
    init (heat: CookingPotHeat) {
        self.heat = heat
        super.init(name: "Cooking Pot", image: "CookingPot", status: false)
    }
}
