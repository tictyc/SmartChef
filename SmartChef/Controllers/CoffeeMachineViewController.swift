//
//  CoffeeMachineViewController.swift
//  SmartChef
//
//  Created by Student on 08.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

class CoffeeMachineViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var cmImage: UIImageView!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var brewButton: UIButton!
    @IBOutlet weak var brewProgress: UIProgressView!
    @IBOutlet weak var strengthSlider: UISlider!
    @IBOutlet weak var coffeePickerView: UIPickerView!
    
    @IBAction func statusSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            coffeeMachine?.status = true
            statusLabel.text = "Coffee Machine is on"
            toggleInteractionChange()
        } else {
            coffeeMachine?.status = false
            statusLabel.text = "Coffee Machine is off"
            toggleInteractionChange()
            }
    }
    
    @IBAction func brewButtonPressed(_ sender: Any) {
        brewProgress.isHidden = false
        
        
        coffeeMachine?.coffeeCounter += 1
    }
    
    var coffeeMachine : CoffeeMachine?
    var coffeeTypeSelection = CoffeeType.Coffee.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coffeePickerView.dataSource = self
        coffeePickerView.delegate = self
        brewButton.setTitle("Brew me a \(pickerCoffeeDataArray[coffeePickerView.selectedRow(inComponent: 0)])", for: .normal)
        
        cmImage.image = coffeeMachine?.image
        
        if coffeeMachine?.status == true {
            statusSwitch.isOn = true
            statusLabel.text = "Coffee Machine is on"
            toggleInteractionChange()
        } else {
            statusSwitch.isOn = false
            statusLabel.text = "Coffee Machine is off"
            toggleInteractionChange()
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerCoffeeDataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerCoffeeDataArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coffeeMachine?.coffeeType = CoffeeType(rawValue: pickerCoffeeDataArray[row])!
        if pickerCoffeeDataArray[row] == CoffeeType.Espresso.rawValue {
            brewButton.setTitle("Brew me an \(pickerCoffeeDataArray[coffeePickerView.selectedRow(inComponent: 0)])", for: .normal)
        } else {
            brewButton.setTitle("Brew me a \(pickerCoffeeDataArray[coffeePickerView.selectedRow(inComponent: 0)])", for: .normal)
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerCoffeeDataArray[row], attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
    
    func toggleInteractionChange (){
        coffeePickerView.isUserInteractionEnabled = !coffeePickerView.isUserInteractionEnabled
        strengthSlider.isEnabled = !strengthSlider.isEnabled
        brewButton.isEnabled = !brewButton.isEnabled
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
