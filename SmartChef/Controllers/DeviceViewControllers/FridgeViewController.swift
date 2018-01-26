//
//  FridgeViewController.swift
//  SmartChef
//
//  Created by Student on 08.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import UIKit

class FridgeViewController: UIViewController {
    
    var fridge : Fridge?
    
    @IBOutlet weak var autoOrdersSwitch: UISwitch!
    @IBOutlet weak var autoOrdersLabel: UILabel!
    
    @IBAction func autoOrdersAction(_ sender: UISwitch) {
        if sender.isOn {
            fridge?.automatedOrders = true
        } else {
            fridge?.automatedOrders = false
        }
        PersistenceService.saveContext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = fridge?.name
        fridge!.automatedOrders ? (autoOrdersSwitch.isOn = true) : (autoOrdersSwitch.isOn = false)
        loadBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadBarButtons()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.popViewController(animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleInteractionOn () {
        autoOrdersLabel.isEnabled = true
        autoOrdersSwitch.isEnabled = true
    }
    
    func toggleInteractionOff () {
        autoOrdersLabel.isEnabled = false
        autoOrdersSwitch.isEnabled = false
    }
    
    
    @objc func addToFavorites() {
        // add device to favorites and refresh UIBarButtonItems
        
        fridge?.isFavorite = true
        PersistenceService.saveContext()
        loadBarButtons()
    }
    
    @objc func removeFromFavorites() {
        // remove device from favorites and refresh UIBarButtonItems
        
        fridge?.isFavorite = false
        PersistenceService.saveContext()
        loadBarButtons()
    }
    
    func loadBarButtons() {
        if fridge?.isFavorite == false {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add to favorites", style: .plain, target: self, action: #selector(addToFavorites))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Remove from favorites", style: .plain, target: self, action: #selector(removeFromFavorites))
        }
    }
}
