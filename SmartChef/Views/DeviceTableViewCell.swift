//
//  DeviceTableViewCell.swift
//  SmartChef
//
//  Created by Student on 01.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {

    @IBOutlet weak var deviceImageView: UIImageView!
    @IBOutlet weak var deviceNameLabel: UILabel!
    
    
    var device: Device? {
        didSet {
            self.updateUI()
        }
    }
    func updateUI() {
        deviceImageView.image = device?.image
        deviceNameLabel.text = device?.name
    }

}
