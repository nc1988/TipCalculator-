//
//  ViewController.swift
//  TipCalculator
//
//  Created by Pham Do Truong on 6/16/16.
//  Copyright © 2016 Pham Do Truong. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var viewOther: UIView!
    @IBOutlet weak var textfieldBill: UITextField!
    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblAmount: UITextField!
    @IBOutlet weak var segTypeTip: UISegmentedControl!
    
    @IBOutlet weak var lbl2p: UILabel!
    
    @IBOutlet weak var lbl5p: UILabel!
    @IBOutlet weak var lbl4p: UILabel!
    @IBOutlet weak var lbl3p: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var lblPercent: UILabel!
    
    var min = 15
    var medium = 25
    var max = 35
    var map_percent = [0.15, 0.25, 0.3]
    var pos_text_y = 0.0
    
    var currency = 0
    
    @IBAction func onChangeDidEnd(sender: AnyObject) {
        UIView.animateWithDuration(0.25, delay:0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            
            
         
//            self.viewOther.alpha = 0.0
            }, completion: { finished in
                
        })
      
    }
    @IBAction func tipSliderEndEdit(sender: AnyObject) {
        updateChange()
    }
    @IBAction func tipSliderEditChange(sender: AnyObject) {
        updateChange()
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setFloat(tipSlider.value, forKey: "last_tip")
    }
    @IBAction func onChangeDidBegan(sender: AnyObject) {
        UIView.animateWithDuration(0.25, delay:0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                       self.viewOther.alpha = 1.0
            }, completion: { finished in
                
        })
        
        updateChange()

        
    }
    
    func saveState(){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(lblAmount.text, forKey: "last_bill")
    }
    
    func applicationWillResignActiveNotification() {
        saveState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector:Selector("applicationWillResignActiveNotification"), name: UIApplicationWillResignActiveNotification, object: nil)
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var value = defaults.integerForKey("default_min")
        if(value == 0) {
            defaults.setInteger(15, forKey: "default_min")
        }
        
        value = defaults.integerForKey("default_medium")
        if(value == 0) {
            defaults.setInteger(25, forKey: "default_medium")
        }
        
        value = defaults.integerForKey("default_max")
        if(value == 0) {
            defaults.setInteger(35, forKey: "default_max")
        }

        lblAmount.delegate = self
        
        
        
        let idx = defaults.integerForKey("default_tip")
        segTypeTip.selectedSegmentIndex = idx
        
        currency = defaults.integerForKey("default_currency")
        pos_text_y = Double(textfieldBill.frame.origin.y)
        
        
        tipSlider.value = defaults.floatForKey("last_tip")
        let last = defaults.stringForKey("last_bill")
        if(last != nil){
            NSLog(last!)

            lblAmount.text = last
            self.viewOther.alpha = 1.0
            updateChange()
        }
        
        
    }
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        segTypeTip.selectedSegmentIndex = 0
        currency = defaults.integerForKey("default_currency")
        min = defaults.integerForKey("default_min")
        medium = defaults.integerForKey("default_medium")
        max = defaults.integerForKey("default_max")
        segTypeTip.setTitle(min.description, forSegmentAtIndex: 0)
        segTypeTip.setTitle(medium.description, forSegmentAtIndex: 1)
        segTypeTip.setTitle(max.description, forSegmentAtIndex: 2)
//        let date = NSDate()
//        defaults.dataForKey(<#T##defaultName: String##String#>)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrency(idx:Int)->String {
        if (idx == 0){
            return "vi_VN"
        }
        else if(idx == 1) {
            return "en_US"
        }
        return "en_US"
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (textField.text?.isEmpty == true && string == "0") {
            return false
        }
        let invalidCharacters = NSCharacterSet(charactersInString: "0123456789.").invertedSet
        return string.rangeOfCharacterFromSet(invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
    }
    
    func updateChange() {
        let billMoney = NSString(string: lblAmount.text!).doubleValue
        var type_tip = Float(0.0)
        if(segTypeTip.selectedSegmentIndex == 0)
        {
            type_tip = Float(min) / 100
        }
        else if(segTypeTip.selectedSegmentIndex == 1)
        {
            type_tip = Float(medium) / 100
        }
        else{
            type_tip = Float(max) / 100
        }
//        let type_tip = Float(tipSlider.value / 100)
//        let tipMoney = billMoney*map_percent[type_tip]
        let tipMoney : Double = billMoney * Double(type_tip)
        lblTip.text = String(format: "%@", Float(Int(tipMoney)).asLocaleCurrency(getCurrency(currency)) )
        
        let totalMoney = billMoney + tipMoney
        
        lblPercent.text = String(format:"%d %% ", Int(tipSlider.value))
        
        lblTotal.text = String(format: "%@", Float(Int(totalMoney)).asLocaleCurrency(getCurrency(currency)) )
        
        lbl2p.text = String(format:"%@", Float(Int(totalMoney/2)).asLocaleCurrency(getCurrency(currency)))
        lbl3p.text = String(format:"%@", Float(Int(totalMoney/3)).asLocaleCurrency(getCurrency(currency)))
        lbl4p.text = String(format:"%@", Float(Int(totalMoney/4)).asLocaleCurrency(getCurrency(currency)))
        lbl5p.text = String(format:"%@", Float(Int(totalMoney/5)).asLocaleCurrency(getCurrency(currency)))
    }

    @IBAction func EditingChanged(sender: UITextField) {
       updateChange()
        
    }
    @IBAction func onChooseTip(sender: AnyObject) {
       updateChange()

    }

    @IBAction func onEndEdit(sender: AnyObject) {
        view.endEditing(true)
    }
}

