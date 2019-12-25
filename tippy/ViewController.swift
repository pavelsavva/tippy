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
        
        // User defaults
        let defaults = UserDefaults.standard
        // Get last bill
        let lastBill = defaults.double(forKey: "lastBill")
        let lastBillDate = defaults.array(forKey: "lastBillDate")  as? [Date] ?? [Date()]
        
        // Sets the title in the Navigation Bar
        self.title = "Tip Calculator"
        
        // Set night mode if switch was set in settings
        if (defaults.bool(forKey: "nightMode")) {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
        
        // Get saved default for tip percentage
        selectedTipPercentage = defaults.double(forKey: "defaultTipPercentage");
        // Highlight the correct tip on the control
        tipControl.selectedSegmentIndex = ViewController.tipPercentages.firstIndex(of: selectedTipPercentage) ?? 0;
        
        // Load last bill amount if not expired
        if(lastBill != 0 && Date().timeIntervalSince(lastBillDate[0]) < 10 * 60 * 1000) {
            billField.text = String(format: "%g", lastBill)
        }
        
        // Recalculate tip
        calculateTipLogic()
    
        keepFirstResponder()
    }
    
    /**
        This function keep the bill amount input field always active
     */
    func keepFirstResponder() {
        DispatchQueue.main.async {
            self.billField.becomeFirstResponder()
        }
    }
    
    /**
        This function responds to user tapping anywhere on the screen and keeps the bill amount input field from loosing focus
     */
    @IBAction func onTap(_ sender: Any) {
        keepFirstResponder()
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        calculateTipLogic()
    }
    
    func convertToLocalCurrency(tip: Double, total: Double) -> (String, String) {
        let locale = Locale.current

        // Convert
        let fmt = NumberFormatter()
        fmt.numberStyle = .currency
        fmt.locale = locale
        let tipString = fmt.string(from: NSNumber(value: tip)) ?? "$0.00"
        let totalString = fmt.string(from: NSNumber(value: total)) ?? "$0.00"
        
        return (tipString, totalString)
    }
    
    func calculateTipLogic() {
        let defaults = UserDefaults.standard
        
        // Get the bill amount
        let bill = Double(billField.text!) ?? 0
        // Calculate the tip and total
        let tip = bill * selectedTipPercentage;
        let total = bill + tip
        
        let tipTotalStrings = convertToLocalCurrency(tip: tip, total: total)
        
        // Update the tip and total balance
        tipLabel.text = tipTotalStrings.0
        totalLabel.text = tipTotalStrings.1
        
        // Get current default
        defaults.set(bill, forKey: "lastBill")
        defaults.set(Date(), forKey: "lastBillDate")
        
        // Force UserDefaults to save.
        defaults.synchronize()
    }
    
    @IBAction func changeTipPercentage(_ sender: Any) {
        // Get tip percentages
        selectedTipPercentage = ViewController.tipPercentages[tipControl.selectedSegmentIndex];
        
        calculateTipLogic()
    }
    
}

