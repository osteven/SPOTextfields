//
//  RandomColorTextFieldDelegate.swift
//  TextFields
//
//  Created by Steven O'Toole on 3/15/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit



class RandomColorTextFieldDelegate: NSObject, UITextFieldDelegate {

    override init() {
        super.init()
        srand48(Int(arc4random()))
    }


    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

        textField.textColor = self.randomColor()
        return true
    }


    func randomColor() -> UIColor {
        let red: CGFloat = randomFloatZeroToOne()
        let green: CGFloat = randomFloatZeroToOne()
        let blue: CGFloat = randomFloatZeroToOne()
        let alpha: CGFloat = 1.0 // randomFloatZeroToOne()

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }


    func randomFloatZeroToOne() -> CGFloat {
        var r = drand48()
        return CGFloat(r)
    }


}