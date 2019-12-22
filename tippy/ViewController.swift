//
//  ViewController.swift
//  tippy
//
//  Created by Pavel Savva on 12/20/19.
//  Copyright © 2019 Pavel Savva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    private var selectedTipPercentage: Double = 0.0
    public static var tipPercentages: [Double] = [0.15, 0.18, 0.2]
    
    override func viewWillAppear(_ animated: Bool) {
        
       // Sets the title in the Navigation Bar
       self.title = "Tip Calculator"
        
        let defaults = UserDefaults.standard

        selectedTipPercentage = defaults.double(forKey: "defaultTipPercentage");
        
        tipControl.selectedSegmentIndex = ViewController.tipPercentages.firstIndex(of: selectedTipPercentage) ?? 0;

        calculateTipLogic()
       // ...
    }

    @IBAction func onTap(_ sender: Any) {
        
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        calculateTipLogic()
    }
    
    func calculateTipLogic() {
        // Get the bill amount
        let bill = Double(billField.text!) ?? 0
        // Calculate the tip and total
        
        let tip = bill * selectedTipPercentage;
        let total = bill + tip
        
        // Update the tip and total balance
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func changeTipPercentage(_ sender: Any) {
        // Get tip percentages
        selectedTipPercentage = ViewController.tipPercentages[tipControl.selectedSegmentIndex];
        
        calculateTipLogic()
    }
    
}

