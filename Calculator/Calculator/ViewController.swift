//
//  ViewController.swift
//  Calculator
//  Student Id: 30113760
//  Created by Juliana de Carvalho on 2020-09-30.
//  Copyright © 2020 Juliana de Carvalho. All rights reserved.
//  Version 1.0
//  Build 1

import UIKit

class ViewController: UIViewController {

    var firstOperand: Double = 0.0
    var secondOperand: Double = 0.0
    var activeOperation: String = ""
    var tempOperand: String = ""
    var chosenOperator: String = ""
    var result = ""
    var calculationInSeries: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBOutlet weak var OperationLabel: UITextView!
    @IBOutlet weak var ResultLabel: UITextView!

    @IBAction func OnNumberButton_Press(_ sender: UIButton) {
    
        switch sender.titleLabel!.text! {
        case "C":
            ResultLabel.text! = "0"
            OperationLabel.text! = ""
            Clear()
        case "⌫":
            ResultLabel.text!.popLast()
            if((ResultLabel.text!.count < 1) || (ResultLabel.text! == "-"))
            {
                ResultLabel.text! = "0"
            }
        case ".":
            if(!ResultLabel.text!.contains("."))
            {
                ResultLabel.text! += "."
            }
        case "+/-":
            if(ResultLabel.text! != "0")
            {
                if(!ResultLabel.text!.contains("-"))
                {
                    ResultLabel.text!.insert("-", at: ResultLabel.text!.startIndex)
                }
                else
                {
                    ResultLabel.text!.remove(at: ResultLabel.text!.startIndex)
                }
            }
        default:
            if(ResultLabel.text == "0")
            {
                ResultLabel.text! = sender.titleLabel!.text!
            }
            else
            {
                ResultLabel.text! += sender.titleLabel!.text!
            }
            ConcatenateOperand(operand: sender.titleLabel!.text!)
        }
    
    
    }
    
    @IBAction func OnOperatorButton_Press(_ sender: UIButton) {
        activeOperation = sender.titleLabel!.text!
        
        if ((ResultLabel.text.contains("+") || ResultLabel.text.contains("-") ||
            ResultLabel.text.contains("x") || ResultLabel.text.contains("÷") )
            && (activeOperation != "=" && activeOperation != "%")){
            calculationInSeries = true
        }
        
        SetOperand(calculationInSeries)
        
        switch(activeOperation)
        {
        case "+":
            ResultLabel.text! += "+"
            chosenOperator = "+"
            
        case "-":
            ResultLabel.text! += "-"
            chosenOperator = "-"
        case "x":
            ResultLabel.text! += "x"
            chosenOperator = "x"
        case "÷":
            ResultLabel.text! += "÷"
            chosenOperator = "÷"
        case "%":
            ResultLabel.text! += "%"
            
            result = CalcResult(operatorSign: chosenOperator)
            chosenOperator = "%"
        case "=":
            
            result = CalcResult(operatorSign: chosenOperator)
            
            OperationLabel.text! = ResultLabel.text!
            ResultLabel.text! = result
            
        default: break
            
        }
    }
    
    func ConcatenateOperand(operand: String){
        tempOperand += operand
    }
    
    var i = 0
    
    func SetOperand(_ CalcInSeries: Bool){
        
        if (CalcInSeries){
            secondOperand = Double(tempOperand)!
            result = CalcResult(operatorSign: chosenOperator)
            firstOperand = Double(result)!
            
        }
        else{
            i += 1
            
            switch i {
                case 1:
                    firstOperand = Double(tempOperand)!
                case 2:
                    secondOperand = Double(tempOperand)!
                    i = 0;
                default:
                    break;
            }
        }
        
        tempOperand = ""
        calculationInSeries = false
    }
    
    func CalcResult(operatorSign: String) -> String {

       
        
        switch operatorSign {
        case "+":
            result = TreatResult(AddNumbers(firstOperand,secondOperand))
        case "-":
            result = TreatResult(SubtractNumbers(firstOperand,secondOperand))
        case "x":
            result = TreatResult(MultiplyNumbers(firstOperand,secondOperand))
        case "÷":
            result = TreatResult(DivideNumbers(firstOperand,secondOperand))
        case "%":
            result = TreatResult(Percentage(Double(result)!))
        default:
            break
        }
        
        if (!calculationInSeries){
            firstOperand = 0.0
            secondOperand = 0.0
            tempOperand = result
        }
        
        
        return result
    }
    
    func AddNumbers(_ number1: Double, _ number2: Double) -> Double {
        return number1 + number2
    }
    
    func SubtractNumbers(_ number1: Double, _ number2: Double) -> Double {
        return number1 - number2
    }
    
    func MultiplyNumbers(_ number1: Double, _ number2: Double) -> Double {
        return number1 * number2
    }
    
    func DivideNumbers(_ number1: Double, _ number2: Double) -> Double {
        return number1 / number2
    }
    
    func TreatResult(_ number: Double) -> String {
        let str = String(number)
        
        if str[str.index(after: str.firstIndex(of: ".")!)] == "0"{
            return String(Int(number))
        }
        else {
            return String(number)
        }
    }
    
    func Percentage(_ number: Double) -> Double{
        return number / 100
    }
    
    func Clear(){
        result = ""
        tempOperand = ""
        i = 0
        firstOperand = 0.0
        secondOperand = 0.0
    }

    
}

