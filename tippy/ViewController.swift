//
//  ViewController.swift
//  tippy
//
//  Created by Pavel Savva on 12/20/19.
//  Copyright © 2019 Pavel Savva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // User defaults
    let defaults = UserDefaults.standard
    
    // Locale
    let locale = Locale.current
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var bottomView: UIView!
    
    private var selectedTipPercentage: Double = 0.0
    public static var tipPercentages: [Double] = [0.15, 0.18, 0.2]
    
    func getLastBill() -> Double? {
        // Get last bill
        let lastBill = defaults.double(forKey: "lastBill")
        let lastBillDate = defaults.array(forKey: "lastBillDate")  as? [Date] ?? [Date()]
        
        // Return last bill amount if not expired
        if(lastBill != 0 && Date().timeIntervalSince(lastBillDate[0]) < 10 * 60 * 1000) {
            return lastBill
        } else {
            return nil
        }
    }
    
    func setUserInterfaceStyle () {
        // Set night mode if switch was set in settings
        if (defaults.bool(forKey: "nightMode")) {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
    
    func setDefaultTipControlValue () {
        // Get saved default for tip percentage
        selectedTipPercentage = defaults.double(forKey: "defaultTipPercentage");
        // Highlight the correct tip on the control
        tipControl.selectedSegmentIndex = ViewController.tipPercentages.firstIndex(of: selectedTipPercentage) ?? 0;
    }
    
    func hideBottomView() {
        UIView.animate(withDuration: 0.4, animations: {
            self.bottomView.alpha = 0
            self.billField.frame.origin.y = 260
            self.bottomView.frame.origin.y = 325
            self.tipControl.frame.origin.y = 285
            self.tipControl.alpha = 0
        })
    }
    
    func showBottomView() {
        UIView.animate(withDuration: 0.4, animations: {
            self.bottomView.alpha = 1
            self.billField.frame.origin.y = 130
            self.bottomView.frame.origin.y = 275
            self.tipControl.frame.origin.y = 235
            self.tipControl.alpha = 1
            
        })
    }
    
    func animateUI() {
        if (billField.text!.isEmpty) {
            hideBottomView()
        } else {
            showBottomView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Load last bill if available
        if let lastBill = getLastBill() {
            billField.text = String(format: "%g", lastBill)
        }
        
        // Set interface colors based on users selection
        setUserInterfaceStyle()
        
        // Set dark/light theme
        setUserInterfaceStyle()
        
        // Open keyboard for the bill input field
        keepFirstResponder()
        
        // Tip control from user defaults
        setDefaultTipControlValue()
        
        // Set bill placeholder to the current currency symbol
        billField.placeholder = getLocalCurrencySymbol()
        
        // Hide/ show bottom view and expand the top one
        animateUI()
        
        // Recalculate tip
        calculateTipLogic()
    }
    
    func getLocalCurrencySymbol() -> String {
        // Convert
        let fmt = NumberFormatter()
        fmt.numberStyle = .currency
        fmt.locale = locale
        
        return fmt.currencySymbol
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
    
    @IBAction func changeBillAmount(_ sender: Any) {
        if (!billField.text!.isEmpty) {
            showBottomView()
        } else {
            hideBottomView()
        }
        
        calculateTipLogic()
    }
    
    func convertToLocalCurrency(tip: Double, total: Double) -> (String, String) {
        // Convert
        let fmt = NumberFormatter()
        fmt.numberStyle = .currency
        fmt.locale = locale
        
        let tipString = fmt.string(from: NSNumber(value: tip)) ?? "$0.00"
        let totalString = fmt.string(from: NSNumber(value: total)) ?? "$0.00"
        
        return (tipString, totalString)
    }
    
    func calculateTipLogic() {
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

