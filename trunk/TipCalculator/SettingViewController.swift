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
        
        segmentCurrency.selectedSegmentIndex = currency
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func onChangeCurrency(sender: AnyObject) {
        currency = segmentCurrency.selectedSegmentIndex
    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(selected, forKey: "default_tip")
            defaults.setInteger(currency, forKey: "default_currency")
            
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
