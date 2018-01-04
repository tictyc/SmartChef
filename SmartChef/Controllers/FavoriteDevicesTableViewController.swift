//
//  FavoriteDevicesTableViewController.swift
//  SmartChef
//
//  Created by Student on 04.01.18.
//  Copyright © 2018 hskl. All rights reserved.
//

import UIKit

class FavoriteDevicesTableViewController: DeviceTableViewController {
    
    var favoriteDevices : [Device] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for device in devices {
            if device.isFavorite == true {
                favoriteDevices.append(device)
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteDevices.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as! DeviceTableViewCell
        let device = favoriteDevices[indexPath.row]
        cell.device = device
        return cell
    }
}
