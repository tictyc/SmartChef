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
    }
    
    @IBAction func brewButtonPressed(_ sender: Any) {
        brewProgress.isHidden = false
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coffeePickerView.dataSource = self
        coffeePickerView.delegate = self
        brewButton.setTitle("Brew me a \(pickerCoffeeDataArray[coffeePickerView.selectedRow(inComponent: 0)])", for: .normal)
        
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
        coffeeMachine?.coffeeType = pickerCoffeeDataArray[row]
        if pickerCoffeeDataArray[row] == "Espresso" {
            brewButton.setTitle("Brew me an \(pickerCoffeeDataArray[coffeePickerView.selectedRow(inComponent: 0)])", for: .normal)
        } else {
            brewButton.setTitle("Brew me a \(pickerCoffeeDataArray[coffeePickerView.selectedRow(inComponent: 0)])", for: .normal)
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerCoffeeDataArray[row], attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
    
    func toggleInteractionOn (){
        coffeePickerView.isUserInteractionEnabled = true
        strengthSlider.isEnabled = true
        brewButton.isEnabled = true
    }
    
    func toggleInteractionOff (){
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
