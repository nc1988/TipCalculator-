//
//  ViewController.swift
//  TipCalculator
//
//  Created by Pham Do Truong on 6/16/16.
//  Copyright © 2016 Pham Do Truong. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {

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
        let defaults = NSUserDefaults.standardUserDefaults()
        var idx = defaults.integerForKey("default_tip")
        segTypeTip.selectedSegmentIndex = idx
        
        pos_text_y = Double(textfieldBill.frame.origin.y)
        
    }
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        var idx = defaults.integerForKey("default_tip")
        segTypeTip.selectedSegmentIndex = idx

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateChange() {
        var billMoney = NSString(string: lblAmount.text!).doubleValue
        var type_tip = segTypeTip.selectedSegmentIndex
        var tipMoney = billMoney*map_percent[type_tip]
        lblTip.text = String(format: "$ %.2f", tipMoney )
        
        var totalMoney = billMoney + tipMoney
        
        
        lblTotal.text = String(format: "$ %.2f", totalMoney )
        
        lbl2p.text = String(format:"$ %.2f", totalMoney/2)
        lbl3p.text = String(format:"$ %.2f", totalMoney/3)
        lbl4p.text = String(format:"$ %.2f", totalMoney/4)
        lbl5p.text = String(format:"$ %.2f", totalMoney/5)
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

