//
//  CalculatorBrain.swift
//  calculator-ios9
//
//  Created by Calvert, Martin on 2/1/17.
//  Copyright © 2017 Calvert, Martin. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private var accumulator = 0.0
    private var pending: PendingBinaryOperationInfo?
    var result: Double {
        get {
            return accumulator
        }
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "−" : Operation.BinaryOperation({ $0 - $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "=" : Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    func performOperand(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .BinaryOperation(let function):
                executePendingOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .Equals:
                executePendingOperation()
            }
        }
    }
    
    private func executePendingOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
}
