//
//  ViewController.swift
//  calculator-ios9
//
//  Created by Calvert, Martin on 1/31/17.
//  Copyright © 2017 Calvert, Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    private var userIsInTheMiddleOfTyping = false
    private var brain = CalculatorBrain()
    private var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(_ sender: UIButton) {
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
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperand(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
    @IBAction private func clearDisplay(_ sender: UIButton) {
        display.text = "0"
        userIsInTheMiddleOfTyping = false
    }
}

