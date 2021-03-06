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
    @IBOutlet weak var strengthSlider: UISlider!
    @IBOutlet weak var coffeePickerView: UIPickerView!
    @IBOutlet weak var strengthLabel: UILabel!
    
    var coffeeMachine : CoffeeMachine?
    
    let onString = "Your Coffee Machine is on."
    let offString = "Your Coffee Machine is off."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UI Setup
        
        self.title = coffeeMachine?.name
        loadBarButtons()
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadBarButtons()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.popViewController(animated: false)
    }
    
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
        var isMilkFilled = true
        
        // if the selected coffee involves milk, check for milk fill level
        if(coffeeMachine?.coffeeType == 1 || coffeeMachine?.coffeeType == 2 || coffeeMachine?.coffeeType == 3) {
            isMilkFilled = checkMilk()
        }
        
        // if water, milk and coffee are filled notify the user of successfull action
        if checkCoffeeBeans() == true && isMilkFilled == true && checkWater() == true {
            let alert = UIAlertController(title: "Your \(pickerCoffeeDataArray[coffeePickerView.selectedRow(inComponent: 0)]) is being brewn and will be ready soon!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default) {
                action in
            })
            self.present(alert, animated: true, completion: nil)
        }
        
        // persist changes made to the coffee fill level attributes
        PersistenceService.saveContext()
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
        // set the coffeeType attribute corresponding to the selected pickerView row
        
        coffeeMachine?.coffeeType = Int16(row)
        if pickerCoffeeDataArray[row] == "Espresso" {
            brewButton.setTitle("Brew me an \(pickerCoffeeDataArray[coffeePickerView.selectedRow(inComponent: 0)])", for: .normal)
        } else {
            brewButton.setTitle("Brew me a \(pickerCoffeeDataArray[coffeePickerView.selectedRow(inComponent: 0)])", for: .normal)
        }
        PersistenceService.saveContext()
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        // set color of the picker view row titles to white
        
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
    
    func checkCoffeeBeans() -> Bool {
        //check coffee beans level and tell the user to refill if necessary
        
        if (coffeeMachine?.coffeeBeansLevel.isLess(than: (coffeeMachine?.strength)!))! {
            fireAlert(title: "The coffee beans are empty and need to be refilled.", confirmationTitle: "Refill")
            self.coffeeMachine?.coffeeBeansLevel = 7.0
            return false
        } else {
            coffeeMachine?.coffeeBeansLevel -= (coffeeMachine?.strength)!
            return true
        }
    }
    
    func checkMilk() -> Bool {
        // check milk level of the coffee machine and tell the user to refill milk if necessary
        
        if (coffeeMachine?.milk)! < 25 {
            fireAlert(title: "The milk is empty and needs to be refilled.", confirmationTitle: "Refill")
            self.coffeeMachine?.milk = 100
            return false
        } else {
            coffeeMachine?.milkLevel -= 25
            return true
        }
    }
    
    func checkWater() -> Bool {
        if (coffeeMachine?.water)! < 15 {
            fireAlert(title: "The water is empty and needs to be refilled.", confirmationTitle: "Refill")
            self.coffeeMachine?.water = 100
            return false
        } else {
            coffeeMachine?.waterLevel = (coffeeMachine?.waterLevel)! - 15
            return true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @objc func addToFavorites() {
        // add device to favorites and refresh UIBarButtonItems
        
        coffeeMachine?.isFavorite = true
        PersistenceService.saveContext()
        loadBarButtons()
    }
    
    @objc func removeFromFavorites() {
        // remove device from favorites and refresh UIBarButtonItems
        
        coffeeMachine?.isFavorite = false
        PersistenceService.saveContext()
        loadBarButtons()
    }
    
    func loadBarButtons() {
        if coffeeMachine?.isFavorite == false {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add to favorites", style: .plain, target: self, action: #selector(addToFavorites))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Remove from favorites", style: .plain, target: self, action: #selector(removeFromFavorites))
        }
    }
}

