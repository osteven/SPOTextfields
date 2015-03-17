//
//  DollarTextFieldDelegate.swift
//  TextFields
//
//  Created by Steven O'Toole on 3/16/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//



//http://stackoverflow.com/questions/27991601/using-swift-how-to-convert-a-string-to-a-number


import Foundation
import UIKit

class DollarTextFieldDelegate: NSObject, UITextFieldDelegate {
    let nonNumberSet = NSCharacterSet(charactersInString: "0123456789").invertedSet
    let toCurrencyConverter = NSNumberFormatter()
    let toCurrencyStyler = NSNumberFormatter()
    let MAX_DOLLAR: Double = 999_999_999_999 // big enough

    override init() {
        super.init()
        toCurrencyConverter.numberStyle = .CurrencyStyle
        toCurrencyConverter.decimalSeparator = "."
        toCurrencyStyler.minimumFractionDigits = 2
        toCurrencyStyler.maximumFractionDigits = 2
        toCurrencyStyler.numberStyle = .CurrencyStyle
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

            // length of new string is zero, but range is one means it's a backspace
        if (range.length == 1 && countElements(string) == 0) { return true }


        let tobeAddedText = string.stringByTrimmingCharactersInSet(nonNumberSet)
        let tobeAddedLength = countElements(tobeAddedText)
        if tobeAddedLength < 1 { return false }   //  non-numbers were to be added

        let originalText = textField.text as NSString
        let newText = originalText.stringByReplacingCharactersInRange(range, withString: tobeAddedText)

        let newValue = toCurrencyConverter.numberFromString(newText)
        if let newDouble = newValue?.doubleValue {
            if newDouble >= MAX_DOLLAR { return false }
            if range.location == originalText.length {    // appending
                let shiftPlaces = Double(tobeAddedLength)
                let newValueShiftedRight = newDouble * pow(10, shiftPlaces)
                if let styledCurrency = toCurrencyStyler.stringFromNumber(newValueShiftedRight) {
                    textField.text = styledCurrency
                    return false
                }
            } else {    // inserting
                if let styledCurrency = toCurrencyStyler.stringFromNumber(newDouble) {
                    textField.text = styledCurrency
                    return false
                }
            }
        }
        // if we got here, the new text is not a number
        return false
    }
}