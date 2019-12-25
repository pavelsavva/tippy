//
//  SettingsViewController.swift
//  tippy
//
//  Created by Pavel Savva on 12/22/19.
//  Copyright © 2019 Pavel Savva. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var nightModeSwith: UISwitch!
    
    override func viewWillAppear(_ animated: Bool) {
        // Access UserDefaults
        let defaults = UserDefaults.standard
        
        // Get current default
        let selectedTipPercentage = defaults.double(forKey: "defaultTipPercentage")
        
        // Set segment menu
        defaultTipControl.selectedSegmentIndex = ViewController.tipPercentages.firstIndex(of: selectedTipPercentage) ?? 0
        
        if (defaults.bool(forKey: "nightMode")) {
            overrideUserInterfaceStyle = .dark
            nightModeSwith.setOn(true, animated: false)
        } else {
            overrideUserInterfaceStyle = .light
            nightModeSwith.setOn(false, animated: false)
        }
    }
    
    
    @IBAction func setDefaulltTipPercentage(_ sender: Any) {
        //Access UserDefaults
        let defaults = UserDefaults.standard
        
        // Set a String value for some key.
    defaults.set(ViewController.tipPercentages[defaultTipControl.selectedSegmentIndex], forKey: "defaultTipPercentage")
        
        // Force UserDefaults to save.
        defaults.synchronize()
    }
    
    @IBAction func changeNightMode(_ sender: Any) {
        //Access UserDefaults
        let defaults = UserDefaults.standard
        var nightMode: Bool
        
        if (nightModeSwith.isOn) {
            nightMode = true
            overrideUserInterfaceStyle = .dark
        } else {
            nightMode = false
            overrideUserInterfaceStyle = .light
        }
        
        defaults.set(nightMode, forKey: "nightMode")
        defaults.synchronize()
        
    }
    
}
