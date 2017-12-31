//
//  CoffeeMachineViewController.swift
//  SmartChef
//
//  Created by Student on 08.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

class CoffeeMachineViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let pickerCoffeeDataArray = [
        "Coffee",
        "Milkcoffee",
        "Cappuchino",
        "Latte Machiatto",
        "Espresso",
        ]
    
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var brewButton: UIButton!
    @IBOutlet weak var brewProgress: UIProgressView!
    @IBOutlet weak var strengthSlider: UISlider!
    @IBOutlet weak var coffeePickerView: UIPickerView!
    @IBOutlet weak var strengthLabel: UILabel!
    
    var coffeeMachine : CoffeeMachine?
    
    let onString = "Your Coffee Machine is on."
    let offString = "Your Coffee Machine is off."
    
    @IBAction func statusSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            coffeeMachine?.status = true
            statusLabel.text = onString
            toggleInteractionOn()
        } else {
            coffeeMachine?.status = false
            statusLabel.text = offString
            toggleInteractionOff()
        }
        PersistenceService.saveContext()
    }
    
   
    @IBAction func stregthSliderTriggered(_ sender: UISlider) {
        coffeeMachine?.strength = sender.value
        PersistenceService.saveContext()
    }
    
    
    @IBAction func brewButtonPressed(_ sender: Any) {
        brewProgress.isHidden = false
        
        if(Double((coffeeMachine?.strength)!) > 0.5)  {
            coffeeMachine?.coffeeBeansLevel = (coffeeMachine?.coffeeBeansLevel)! - 50
        } else if (Double((coffeeMachine?.strength)!) < 0.5) {
            coffeeMachine?.coffeeBeansLevel = (coffeeMachine?.coffeeBeansLevel)! - 25
        }
        
        if(coffeeMachine?.coffeeType == 1 || coffeeMachine?.coffeeType == 2 || coffeeMachine?.coffeeType == 3) {
            coffeeMachine?.milkLevel = (coffeeMachine?.milkLevel)! - 25
        }
    
        coffeeMachine?.waterLevel = (coffeeMachine?.waterLevel)! - 15
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = coffeeMachine?.name
        
        coffeePickerView.dataSource = self
        coffeePickerView.delegate = self
        strengthSlider.value = (coffeeMachine?.strength)!
    coffeePickerView.selectRow(Int(Int32(coffeeMachine!.coffeeType)), inComponent: 0, animated: false)
        
        if pickerCoffeeDataArray[Int(Int32(coffeeMachine!.coffeeType))] == "Espresso" {
            brewButton.setTitle("Brew me an \(pickerCoffeeDataArray[coffeePickerView.selectedRow(inComponent: 0)])", for: .normal)
        } else {
            brewButton.setTitle("Brew me a \(pickerCoffeeDataArray[coffeePickerView.selectedRow(inComponent: 0)])", for: .normal)
        }
        
        if coffeeMachine?.status == true {
            statusSwitch.isOn = true
            statusLabel.text = onString
            toggleInteractionOn()
        } else {
            statusSwitch.isOn = false
            statusLabel.text = offString
            toggleInteractionOff()
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
        coffeeMachine?.coffeeType = Int16(row)
        if pickerCoffeeDataArray[row] == "Espresso" {
            brewButton.setTitle("Brew me an \(pickerCoffeeDataArray[coffeePickerView.selectedRow(inComponent: 0)])", for: .normal)
        } else {
            brewButton.setTitle("Brew me a \(pickerCoffeeDataArray[coffeePickerView.selectedRow(inComponent: 0)])", for: .normal)
        }
        PersistenceService.saveContext()
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerCoffeeDataArray[row], attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
    
    func toggleInteractionOn (){
        strengthLabel.isEnabled = true
        coffeePickerView.isUserInteractionEnabled = true
        strengthSlider.isEnabled = true
        brewButton.isEnabled = true
    }
    
    func toggleInteractionOff (){
        strengthLabel.isEnabled = false
        coffeePickerView.isUserInteractionEnabled = false
        strengthSlider.isEnabled = false
        brewButton.isEnabled = false
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

