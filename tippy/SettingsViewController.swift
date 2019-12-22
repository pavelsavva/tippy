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
    
    override func viewWillAppear(_ animated: Bool) {
        // Access UserDefaults
        let defaults = UserDefaults.standard

        // Get current default
        let selectedTipPercentage = defaults.double(forKey: "defaultTipPercentage");
        
        // Set segment menu
        defaultTipControl.selectedSegmentIndex = ViewController.tipPercentages.firstIndex(of: selectedTipPercentage) ?? 0;
    }
    

    @IBAction func setDefaulltTipPercentage(_ sender: Any) {
        //Access UserDefaults
        let defaults = UserDefaults.standard

        // Set a String value for some key.
        defaults.set(ViewController.tipPercentages[defaultTipControl.selectedSegmentIndex], forKey: "defaultTipPercentage")

        // Force UserDefaults to save.
        defaults.synchronize()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
