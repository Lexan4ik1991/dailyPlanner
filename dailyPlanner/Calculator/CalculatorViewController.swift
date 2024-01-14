//
//  CalculatorViewController.swift
//  dailyPlanner
//
//  Created by 123 on 12.01.2024.
//
import UIKit

// enum для определения типа математической операции
enum Operation {
case add
case subtract
case multiply
case divide
}

class CalculatorViewController: UIViewController {
    // переменная для хранения числа, отображаемого на экране
    var numberOnScreen: Double = 0;
    // переменная для хранения предыдущего числа
    var previousNumber: Double = 0;
    // флаг, указывающий выполняется ли математическая операция в данный момент
    var performingMath = false;
    // переменная для хранения операции
    var operation: Operation?
    
    @IBOutlet weak var label: UILabel!
    
    // функция для обработки нажатий на кнопки с цифрами
    @IBAction func numbers(_ sender: UIButton) {
        // добавил надпись в лейбл при открытии калькулятора
        label.text = label.text?.replacingOccurrences(of: "Enter number", with: "")
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
    
    // функция для обработки нажатий на кнопки с операциями
    @IBAction func buttons(_ sender: UIButton) {
        //добавил удаление лейбла при нажатии на любую цыфру
        if label.text != "" && sender.tag != 11 && sender.tag != 12 {
            guard let oldNumber = Double(label.text!) else { return }
            previousNumber = oldNumber
            
            switch sender.tag {
            case 16:
                label.text = "/"
                operation = .divide
            case 15:
                label.text = "x"
                operation = .multiply
            case 14:
                label.text = "-"
                operation = .subtract
            case 13:
                label.text = "+"
                operation = .add
            default:
                break
            }
            
            // установка значения флага performingMath в true
            performingMath = true
        } else if sender.tag == 12 {
            guard let operation = self.operation else { return }
            
            switch operation {
            case .divide:
                // проверка на деление на ноль
                guard numberOnScreen != 0 else { return }
                label.text = String(previousNumber / numberOnScreen)
            case .multiply:
                label.text = String(previousNumber * numberOnScreen)
            case .subtract:
                label.text = String(previousNumber - numberOnScreen)
            case .add:
                label.text = String(previousNumber + numberOnScreen)
            }
        } else if sender.tag == 11 {
            // обработка нажатия на кнопку с символом "С"
            label.text = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = nil
        }
    }
    // функция удаления надписи из лейбла
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    label.text = label.text?.replacingOccurrences(of: "Enter number", with: "")
    }
    override func viewDidLoad() {
    super.viewDidLoad()
    label.text = "Enter number"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // освобождаем ненужные ресурсы при нехватке памяти
    }
}
