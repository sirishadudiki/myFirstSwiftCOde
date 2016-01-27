//
//  ViewController.swift
//  calculator
//
//  Created by Sirisha Dudiki on 1/19/16.
//  Copyright © 2016 traning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    
    var userIsInTheMiddleOfTypingANumber: Bool = false

    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        print("digit = \(digit)")
        
        // Test Git Commit
        if userIsInTheMiddleOfTypingANumber
        {
            display.text = display.text! + digit
        }
        else
        {
            display.text = digit;
            userIsInTheMiddleOfTypingANumber = true
        }
    }

    var operandStack = Array<Double>()
    @IBAction func enter() {

        operandStack.append(displayValue)
        print("Operand Stack = \(operandStack)")
        
        userIsInTheMiddleOfTypingANumber = false
    }
    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)";
        }
        
    }
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber
        {
            enter()
        }
        
        switch operation{
        case "➕":
            performOperation {$0 + $1}
        case "➖":
            performOperation {$1 - $0}
        case "➗":
            performOperation {$0 / $1}
        case "✖️":
            performOperation {$1 * $0}
        case "⑀":
            performOperationOneParameter {sqrt($0)}
        case "CLR":
            clear()
            
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2{
            displayValue =  operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperationOneParameter(operation: Double -> Double){
        if operandStack.count >= 1{
            displayValue =  operation(operandStack.removeLast())
            enter()
        }
    }
    
    func clear(){
        userIsInTheMiddleOfTypingANumber = false;
        operandStack.removeAll();
        displayValue = 0;
    }
    
}

