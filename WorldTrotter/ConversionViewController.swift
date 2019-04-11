//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Prince Kumar on 2019/04/08.
//  Copyright © 2019 Prince Kumar. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view")
        updateCelciusLabel()
    }
    
    @IBOutlet var celciusLabel: UILabel!
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelciusLabel()
        }
    }
    var celciusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    func updateCelciusLabel() {
        if let celciusValue = celciusValue {
            celciusLabel.text = numberFormatter.string(from: NSNumber(value: celciusValue.value))
        } else {
            celciusLabel.text = "???"
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentLocale = Locale.current
        let decimalSeprator = currentLocale.decimalSeparator ??  "."
        
        let existingTextHasDecimalSeprator = textField.text?.range(of: decimalSeprator)
        let replacementTextHasDecimalSeprator = string.range(of: decimalSeprator)
        if existingTextHasDecimalSeprator != nil,
            replacementTextHasDecimalSeprator != nil {
            return false
        } else {
            return true
        }
    }
    
    @IBOutlet var textField: UITextField!
    @IBAction func dismissKeyboard(_sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
}
