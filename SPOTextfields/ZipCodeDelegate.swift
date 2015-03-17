//
//  ZipCodeDelegate.swift
//  TextFields
//
//  Created by Steven O'Toole on 3/15/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//
/* based on:
http://stackoverflow.com/questions/2738026/backspace-not-working-when-implementing-shouldchangecharactersinrange-method-i
*/



import Foundation
import UIKit

class ZipCodeDelegate:  NSObject, UITextFieldDelegate {

    let nonNumberSet = NSCharacterSet(charactersInString: "0123456789").invertedSet

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let stringLength = countElements(string)

        // length of new string is zero, but range is one means it's a backspace
        if (range.length == 1 && stringLength == 0) { return true }

        let tobeAddedText = string.stringByTrimmingCharactersInSet(nonNumberSet)
        let tobeAddedLength = countElements(tobeAddedText)
        if tobeAddedLength < stringLength { return false }   //  non-numbers were to be added

            // reject tapped or pasted-in numbers if total will be too long
        let textFieldBeforeChange = textField.text
        let oldTextLength = countElements(textFieldBeforeChange)
        return ((tobeAddedLength + oldTextLength) <= 5);
    }
}