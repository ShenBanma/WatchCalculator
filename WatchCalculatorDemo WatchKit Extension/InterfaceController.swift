//
//  InterfaceController.swift
//  WatchCalculatorDemo WatchKit Extension
//
//  Created by 沈家瑜 on 15/8/16.
//  Copyright (c) 2015年 沈家瑜. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    //每次 第一次输入
    var firstInputing = true
    
    var firstInputPoint = true
    
    var textValue = "0"
    
    var numbersArray = [Double]()
    
    var secondClick = false
    
    var secondClickSame = false
    
    //运算符数值 0-nil 1-加 2-减 3-乘 4-除
    var computeNumber = 0
    
    var lastComputeNumber = 0

    @IBOutlet weak var labelShowNumber: WKInterfaceLabel!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    
    func inputNumber(number: Int) {
        if firstInputing {
            textValue = "\(number)"
            firstInputing = false
        }else {
            textValue += "\(number)"
        }
        labelShowNumber.setText(textValue)
    }
    
    func secondInputing(computrString: String) {
        if secondClick && secondClickSame {
            return
        }
        if secondClick && !secondClickSame {
            textValue = computrString
            labelShowNumber.setText(textValue)
            firstInputing = true
            firstInputPoint = true
            return
        }
        let number = (textValue as NSString).doubleValue
        numbersArray.append(number)
        firstInputing = true
        firstInputPoint = true
        textValue = computrString
        labelShowNumber.setText(textValue)
    }
    
    func getComputeValue(number: Int) -> ((Double, Double) ->Double)? {
        switch number {
        case 1: return {$0 + $1}
        case 2: return {$1 - $0}
        case 3: return {$0 * $1}
        case 4: return {$1 / $0}
        default: return nil
        }
    }
    
    func getResult(computeValue: ((Double, Double) ->Double)?) {
        let number = (textValue as NSString).doubleValue
        numbersArray.append(number)
        if let computeValue = computeValue {
            let result = computeValue(numbersArray.removeLast(), numbersArray.removeLast())
            numbersArray.append(result)
            textValue = "\(result)"
            labelShowNumber.setText(textValue)
            firstInputing = true
            firstInputPoint = true
            secondClick = false
            secondClickSame = false
            computeNumber = 0
            lastComputeNumber = 0
        }
    }
    
    //数字按钮

    @IBAction func button1() {
        inputNumber(1)
    }
    @IBAction func button2() {
        inputNumber(2)
    }
    @IBAction func button3() {
        inputNumber(3)
    }
    @IBAction func button4() {
        inputNumber(4)
    }
    @IBAction func button5() {
        inputNumber(5)
    }
    @IBAction func button6() {
        inputNumber(6)
    }
    @IBAction func button7() {
        inputNumber(7)
    }
    @IBAction func button8() {
        inputNumber(8)
    }
    @IBAction func button9() {
        inputNumber(9)
    }
    @IBAction func button0() {
        inputNumber(0)
    }
    //.
    @IBAction func button19() {
        if firstInputPoint {
            if firstInputing {
                textValue = "."
                firstInputing = false
            }else {
                textValue += "."
            }
            labelShowNumber.setText(textValue)
            firstInputPoint = false
        }
    }
    
    //运算按钮
    
    //C
    @IBAction func button11() {
        firstInputPoint = true
        firstInputing = true
        computeNumber = 0
        lastComputeNumber = 0
        secondClickSame = false
        secondClick = false
        numbersArray.removeAll(keepCapacity: false)
        textValue = "0"
        labelShowNumber.setText(textValue)
    }
    //+/-
    @IBAction func button12() {
        let number = (textValue as NSString).doubleValue
        textValue = "\(-number)"
        labelShowNumber.setText(textValue)
    }
    //%
    @IBAction func button13() {
        let number = (textValue as NSString).doubleValue
        textValue = "\(number / 100)"
        labelShowNumber.setText(textValue)
    }
    //除
    @IBAction func button14() {
        computeNumber = 4
        if lastComputeNumber != 0 {
            secondClick = true
            
            if lastComputeNumber == computeNumber {
                secondClickSame = true
            } else {
                secondClickSame = false
            }
        }
        lastComputeNumber = 4
        secondInputing("÷")
    }
    //乘
    @IBAction func button15() {
        computeNumber = 3
        if lastComputeNumber != 0 {
            secondClick = true
            
            if lastComputeNumber == computeNumber {
                secondClickSame = true
            } else {
                secondClickSame = false
            }
        }
        lastComputeNumber = 3
        secondInputing("×")
    }
    //减
    @IBAction func button16() {
        computeNumber = 2
        if lastComputeNumber != 0 {
            secondClick = true
            
            if lastComputeNumber == computeNumber {
                secondClickSame = true
            } else {
                secondClickSame = false
            }
        }
        lastComputeNumber = 2
        secondInputing("−")
    }
    //加
    @IBAction func button17() {
        computeNumber = 1
        if lastComputeNumber != 0 {
            secondClick = true
            
            if lastComputeNumber == computeNumber {
                secondClickSame = true
            } else {
                secondClickSame = false
            }
        }
        lastComputeNumber = 1
        secondInputing("+")
    }
    //=
    @IBAction func button18() {
        getResult(getComputeValue(computeNumber))
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
