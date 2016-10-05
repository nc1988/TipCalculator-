//
//  SettingViewController.swift
//  TipCalculator
//
//  Created by Pham Do Truong on 6/20/16.
//  Copyright © 2016 Pham Do Truong. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate    {
    @IBOutlet weak var tipPicker: UIPickerView!
    @IBOutlet weak var segmentCurrency: UISegmentedControl!
    var pickerDataSource = ["15%", "25%", "30%"]
    @IBOutlet weak var lblMin: UILabel!
    @IBOutlet weak var lblMedium: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var stepperMin: UIStepper!
    
    @IBOutlet weak var stepperMedium: UIStepper!
    
    @IBOutlet weak var stepperMax: UIStepper!
    
    var selected = 0
    var currency = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tipPicker.dataSource = self;
        self.tipPicker.delegate = self;
        let defaults = NSUserDefaults.standardUserDefaults()
        selected = defaults.integerForKey("default_tip")
self.tipPicker.selectRow(selected, inComponent: 0, animated: false)

        currency = defaults.integerForKey("default_currency")
        var value = defaults.integerForKey("default_min")
        if(value == 0) {
            value = 15
        }
        stepperMin.value = Double(value)
        lblMin.text = value.description
        value = defaults.integerForKey("default_medium")
        if(value == 0) {
            value = 25
        }
        stepperMedium.value = Double(value)
        lblMedium.text = value.description
        value = defaults.integerForKey("default_max")
        if(value == 0) {
            value = 35
        }
        stepperMax.value = Double(value)
        lblMax.text = value.description
        
        segmentCurrency.selectedSegmentIndex = currency
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func minStepperChange(sender: AnyObject) {
        lblMin.text = Int(stepperMin.value).description
    }
    
    @IBAction func mediumStepperChange(sender: AnyObject) {
        lblMedium.text = Int(stepperMedium.value).description
    }
    
    @IBAction func maxStepperChange(sender: AnyObject) {
        lblMax.text = Int(stepperMax.value).description
    }
    @IBAction func onChangeCurrency(sender: AnyObject) {
        currency = segmentCurrency.selectedSegmentIndex
    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(selected, forKey: "default_tip")
            defaults.setInteger(currency, forKey: "default_currency")

            defaults.setInteger(Int(stepperMin.value), forKey: "default_min")
            defaults.setInteger(Int(stepperMedium.value), forKey: "default_medium")
            defaults.setInteger(Int(stepperMax.value), forKey: "default_max")

        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        selected = row
        return pickerDataSource[row]
    }
   
    
}
