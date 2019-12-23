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
        
        let defaults = UserDefaults.standard
        
        // Sets the title in the Navigation Bar
        self.title = "Tip Calculator"
        
        // Get saved default for tip percentage
        selectedTipPercentage = defaults.double(forKey: "defaultTipPercentage");
        tipControl.selectedSegmentIndex = ViewController.tipPercentages.firstIndex(of: selectedTipPercentage) ?? 0;
        
        // Get last bill
        let lastBill = defaults.double(forKey: "lastBill")
        let lastBillDate = defaults.array(forKey: "lastBillDate")  as? [Date] ?? [Date()]
        if(lastBill != 0 && Date().timeIntervalSince(lastBillDate[0]) < 10 * 60 * 1000) {
            billField.text = String(format: "%g", lastBill)
        }
        
        calculateTipLogic()
        keepFirstResponder()
    }
    
    func keepFirstResponder() {
        DispatchQueue.main.async {
            self.billField.becomeFirstResponder()
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        calculateTipLogic()
    }
    
    @IBAction func tap(_ sender: Any) {
        keepFirstResponder()
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
        
        // Force UserDefaults to save.
        defaults.synchronize()
    }
    
    @IBAction func changeTipPercentage(_ sender: Any) {
        // Get tip percentages
        selectedTipPercentage = ViewController.tipPercentages[tipControl.selectedSegmentIndex];
        
        calculateTipLogic()
    }
    
}

