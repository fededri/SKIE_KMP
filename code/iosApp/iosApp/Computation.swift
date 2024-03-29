//
//  Computation.swift
//  iosApp
//
//  Created by Federico Torres on 08/03/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import shared

class Computation : ObservableObject {
    @Published var readout = "0"
    @Published var op : OperationType? = nil
    
    var previousNumber = ""
    var current = ""
    var replaceDigit = true

    func handleNumericTyping(entryType : EntryType, inputValue: String) {
        switch (entryType) {
        case .numeric:
            if (replaceDigit) {
                current = inputValue
            } else {
                if (inputValue == "." ) {
                    if (!current.contains(".")) {
                        current = current+inputValue
                    }
                } else {
                    current = current+inputValue
                }
            }
            replaceDigit = false
            readout = current
        case .operation:
            replaceDigit = inputValue != "<"
        }
    }
    
    func handleMathOperation(operationType: OperationType) {
        switch onEnum(of: operationType) {                   // 1
            case .clear:
                doClear()
            case .delete:
                doDelete()
            case .equals:
                doEquals()
            case .plus,                                          // 2
                .minus,
                .multiply,
                .divide:
                doMathOperation(operationType: operationType)
        case .unknown(let result):
            print("\(result.message)")
        }
    }
    
    func input(inputValue: String) {
        let entryType = EntryTypesKt.lookupEntryType(value: inputValue)

        handleNumericTyping(entryType: entryType, inputValue: inputValue)
        
        if (entryType == .operation) {
            let operationType = OperationTypeKt.lookupOperationType(
                value: inputValue
            )
            handleMathOperation(operationType: operationType)
        }
    }
    
    func doClear() {
        replaceDigit = true
        current = ""
        previousNumber = ""
        op = nil
        readout = "0"
    }
    
    func doDelete() {
        if (current.count > 0) {
            current.remove(at: current.index(before: current.endIndex))
            if (current.count == 0){
                readout = "0"
            } else {
                readout = current
            }
        }
    }
    
    func doEquals() {
        if (previousNumber.count > 0 && current.count > 0 && op != nil) {
            let result = doMath()
            previousNumber = result
            current = result
            readout = result
        }
        replaceDigit = true
        op = nil
    }
    
    func doMath() -> String {
        let prev = Double(previousNumber)!
        let curr = Double(current)!
        var result = ""
        if (op is OperationType .Plus) {
            result = "\(prev + curr)"
        } else if (op is OperationType .Minus) {
            result = "\(prev - curr)"
        } else if (op is OperationType .Multiply) {
            result = "\(prev * curr)"
        } else if (op is OperationType .Divide) {
            result = "\(prev / curr)"
        }
        return result
    }
    
    private func doMathOperation(operationType: OperationType) {
        if (previousNumber.count > 0 && op != nil) {
            previousNumber = "\(doMath())"
            readout = previousNumber
            op = operationType
        } else {
            previousNumber = current
            op = operationType
        }
    }
    
    /*@Published var op : OperationType? = nil

    var previousNumber = ""
    var current = ""
    var replaceDigit = true
    
    
    
    func handleMathOperation(operationType: OperationType) {
        switch operationType {
        case is OperationType.Clear:
            doClear()
        case is OperationType.Delete:
            doDelete()
        case is OperationType.Equals:
            doEquals()
        case is OperationType.Plus,
            is OperationType.Minus,
            is OperationType.Multiply,
            is OperationType.Divide:
            doMathOperation(operationType: operationType)
        default:
            failApp() // This should never happen :)
        }
    }
    
  
    
    private func failApp(){}
    
    func handleNumericTyping(entryType : EntryType, inputValue: String) {
        switch (entryType) {
        case .numeric:
            if (replaceDigit) {
                current = inputValue
            } else {
                if (inputValue == "." ) {
                    if (!current.contains(".")) {
                        current = current+inputValue
                    }
                } else {
                    current = current+inputValue
                }
            }
            replaceDigit = false
            readout = current
        case .operation:
            replaceDigit = inputValue != "<"
        default:
            print("Do nothing")
        }
    }
    
  
    
   */
}
