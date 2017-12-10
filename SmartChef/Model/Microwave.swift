//
//  Microwave.swift
//  SmartChef
//
//  Created by Student on 10.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

enum MicrowaveWatt: UInt {
    case A = 400
    case B = 600
    case C = 800
    case D = 1000
}

enum MicrowaveMode {
    case Grilling
    case Microwaving
    case Convection
}

class MicroWave: Device {
    var watt: MicrowaveWatt
    var mode: MicrowaveMode
    var timer: Double
    init(watt: MicrowaveWatt, mode: MicrowaveMode, timer: Double) {
        self.watt = watt
        self.mode = mode
        self.timer = timer
        super.init(name: "Microwave", image: "Microwave", status: false)
    }
    func setWatt(newWatt:MicrowaveWatt) {
        watt = newWatt
    }
    func getWatt() -> MicrowaveWatt {
        return watt
    }
    func setMode(newMode:MicrowaveMode) {
        mode = newMode
    }
    func getMode() -> MicrowaveMode {
        return mode
    }
    func setTimer(newTime:Double) {
        timer = newTime
    }
    func getTimer() -> Double {
        return timer
    }
}

