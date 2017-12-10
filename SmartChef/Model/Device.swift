//
//  Devices.swift
//  SmartChef
//
//  Created by Student on 01.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

class Device {
    var name: String
    var image: UIImage
    var status: Bool
    
    init(name: String, image: String, status: Bool) {
        self.name = name
        self.status = status
        if let image = UIImage(named: image) {
            self.image = image
        } else {
            self.image = UIImage(named: "default")!
        }
    }
    func setStatus (newStatus: Bool) {
        status = newStatus
    }
    func getStatus () -> Bool {
        return status
    }
    func getName () -> String {
        return name
    }
}







