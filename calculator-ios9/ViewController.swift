//
//  ViewController.swift
//  calculator-ios9
//
//  Created by Calvert, Martin on 1/31/17.
//  Copyright © 2017 Calvert, Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        if let digit = sender.currentTitle {
            if userIsInTheMiddleOfTyping {
                if let textCurrentlyInDisplay = display.text {
                    display.text = textCurrentlyInDisplay + digit
                }
            } else {
                userIsInTheMiddleOfTyping = true
                display.text = digit
            }
        } else {
            display.text = "No Digit"
        }
    }
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            if mathematicalSymbol == "π" {
                display.text = String(M_PI)
            }
        }
    }
    @IBAction func clearDisplay(_ sender: UIButton) {
        display.text = "0"
        userIsInTheMiddleOfTyping = false
    }
}

