//
//  CalculatorViewController.swift
//  dailyPlanner
//
//  Created by 123 on 12.01.2024.
//

import Foundation
import UIKit

class CalculatorViewController: UIViewController {
    // переменная для хранения числа, отображаемого на экране
    var numberOnScreen: Double = 0;
    // переменная для хранения предыдущего числа
    var previousNumber: Double = 0;
    // флаг, указывающий выполняется ли математическая операция в данный момент
    var performingMath = false;
    // переменная для хранения операции
    var operation = 0;
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) {
        if performingMath == true {
            // отображение числа на экране
            label.text = String(sender.tag-1)
            guard let number = Double(label.text!) else { return }  
            numberOnScreen = number
            //установка значения флага performingMath в false
            performingMath = false
        } else {
            //отображение числа на экране
            label.text = label.text! + String(sender.tag-1)
            guard let number = Double(label.text!) else { return }
            numberOnScreen = number
        }
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        if label.text != "" && sender.tag != 11 && sender.tag != 12 {
            guard let oldNumber = Double(label.text!) else { return }
            previousNumber = oldNumber
            // проверка значения тега кнопки и выполнение соответствующей операции
            if sender.tag == 16 { //Divide
                label.text = "/"
            }
            
            if sender.tag == 15 { //Multiply
                label.text = "x"
            }
            
            if sender.tag == 14 { //Subtract
                label.text = "-"
            }
            
            if sender.tag == 13 { //Add
                label.text = "+"
            }
            
            operation = sender.tag
            // установка значения флага performingMath в true
            performingMath = true
        } else if sender.tag == 12 {
            if operation == 12 { //Divide
                // проверка на деление на ноль
                guard numberOnScreen != 0 else { return }
                label.text = String(previousNumber / numberOnScreen)
            } else if operation == 15 { //Multiply
                label.text = String(previousNumber * numberOnScreen)
            } else if operation == 14 { //Subtract
                label.text = String(previousNumber - numberOnScreen)
            } else if operation == 13 { //Add
                label.text = String(previousNumber + numberOnScreen)
            }
            // нажатие на "с" или очичтка экрана
        } else if sender.tag == 11 {
            label.text = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
    