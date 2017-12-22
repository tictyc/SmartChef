//
//  CountdownData.swift
//  SmartChef
//
//  Created by Student on 22.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import Foundation

class CountdownData {
    class func getData() -> [CountdownModel] {
        var data = [CountdownModel]()
        data.append(CountdownModel(second: "1 Second", minute: "1Minute"))
    }
}
