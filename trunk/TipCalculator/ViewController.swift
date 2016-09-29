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
    var map_percent = [0.15, 0.25, 0.3]
    var pos_text_y = 0.0
    
    var currency = 0
    
    @IBAction func onChangeDidEnd(sender: AnyObject) {
        UIView.animateWithDuration(0.25, delay:0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            
         
            self.viewOther.alpha = 0.0
            }, completion: { finished in
                
        })
      
    }
    @IBAction func onChangeDidBegan(sender: AnyObject) {
        UIView.animateWithDuration(0.25, delay:0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                       self.viewOther.alpha = 1.0
            }, completion: { finished in
                
        })
        
        updateChange()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lblAmount.delegate = self
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let idx = defaults.integerForKey("default_tip")
        segTypeTip.selectedSegmentIndex = idx
        
        currency = defaults.integerForKey("default_currency")
        pos_text_y = Double(textfieldBill.frame.origin.y)
        
    }
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let idx = defaults.integerForKey("default_tip")
        segTypeTip.selectedSegmentIndex = idx
        currency = defaults.integerForKey("default_currency")

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
        let invalidCharacters = NSCharacterSet(charactersInString: "0123456789").invertedSet
        return string.rangeOfCharacterFromSet(invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
    }
    
    func updateChange() {
        let billMoney = NSString(string: lblAmount.text!).doubleValue
        let type_tip = segTypeTip.selectedSegmentIndex
        let tipMoney = billMoney*map_percent[type_tip]
        lblTip.text = String(format: "%@", Float(tipMoney).asLocaleCurrency(getCurrency(currency)) )
        
        let totalMoney = billMoney + tipMoney
        
        
        
        lblTotal.text = String(format: "%@", Float(totalMoney).asLocaleCurrency(getCurrency(currency)) )
        
        lbl2p.text = String(format:"%@", Float(totalMoney/2).asLocaleCurrency(getCurrency(currency)))
        lbl3p.text = String(format:"%@", Float(totalMoney/3).asLocaleCurrency(getCurrency(currency)))
        lbl4p.text = String(format:"%@", Float(totalMoney/4).asLocaleCurrency(getCurrency(currency)))
        lbl5p.text = String(format:"%@", Float(totalMoney/5).asLocaleCurrency(getCurrency(currency)))
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

