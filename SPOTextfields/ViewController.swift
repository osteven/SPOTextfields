//
//  ViewController.swift
//  SPOTextfields
//
//  Created by Steven O'Toole on 3/17/15.
//  Copyright (c) 2015 Steven O'Toole. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var colorizerTextField: UITextField!
    @IBOutlet weak var countCharsTextField: UITextField!

    @IBOutlet weak var randomColorTextField: UITextField!

    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var dollarTextField: UITextField!

    @IBOutlet weak var switchableTextField: UITextField!

    @IBOutlet weak var charCountLabel: UILabel!
    @IBOutlet weak var fieldControlSwitch: UISwitch!


    // Text Field Delegate objects
    let emojiDelegate = EmojiTextFieldDelegate()
    let colorizerDelegate = ColorizerTextFieldDelegate()
    let randomColorDelegate = RandomColorTextFieldDelegate()
    let zipCodeDelegate = ZipCodeDelegate()
    let dollarDelegate = DollarTextFieldDelegate()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.charCountLabel.hidden = true

        self.emojiTextField.delegate = emojiDelegate
        self.colorizerTextField.delegate = colorizerDelegate
        self.countCharsTextField.delegate = self
        self.randomColorTextField.delegate = randomColorDelegate
        self.zipCodeTextField.delegate = zipCodeDelegate
        self.dollarTextField.delegate = dollarDelegate
        self.switchableTextField.delegate = self

    }


    // Text Field Delegate Methods

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == countCharsTextField {
            return handleCharCountField(textField, range: range, replacementString: string)
        }

        return fieldControlSwitch.on
    }

    func handleCharCountField(textField: UITextField, range: NSRange, replacementString string: String) -> Bool {

        // Figure out what the new text will be, if we return true
        var newText: NSString = textField.text
        newText = newText.stringByReplacingCharactersInRange(range, withString: string)

        // hide the label if the newText will be an empty string
        self.charCountLabel.hidden = (newText.length == 0)

        // Write the length of newText into the label
        self.charCountLabel.text = String(newText.length)

        // returning true gives the text field permission to change its text
        return true;
    }


}

