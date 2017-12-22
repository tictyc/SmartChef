//
//  CountdownModelPicker.swift
//  SmartChef
//
//  Created by Student on 22.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

class CountdownModelPicker: UIPickerView {

    var modelData: [CountdownModel]!

}

extension CountdownModelPicker: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modelData.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
}

extension CountdownModelPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return modelData[row].minute
    }
}
