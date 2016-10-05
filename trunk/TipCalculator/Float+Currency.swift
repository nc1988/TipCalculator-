//
//  Float+Currency.swift
//  TipCalculator
//
//  Created by MAC on 9/29/16.
//  Copyright © 2016 Pham Do Truong. All rights reserved.
//

import Foundation

extension Float{
    
    func asLocaleCurrency(str_locale: String)->String{
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.init(localeIdentifier:str_locale)
        return formatter.stringFromNumber(self)!
    }
    
    func asLocaleCurrency1(str_locale: String)->String{
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter.stringFromNumber(self)!
    }
}