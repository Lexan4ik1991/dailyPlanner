//
//  CalculatorViewController.swift
//  dailyPlanner
//
//  Created by 123 on 11.01.2024.
//
//для мужчин: 10 х вес (кг) + 6,25 x рост (см) – 5 х возраст (г) + 5;
//для женщин: 10 x вес (кг) + 6,25 x рост (см) – 5 x возраст (г) – 161.
import Foundation
import UIKit

class CalculatorViewController : UIViewController{
    
 
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var height: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.addTarget(self, action: #selector(startButtonTapped(_:)), for: .touchUpInside)

    }

    @IBAction func startButtonTapped(_ sender: Any) {
        if let ageString = age.text, let weightString = weight.text, let heightString = height.text {
            if let age = Double(ageString), let weight = Double(weightString), let height = Double(heightString) {
                let resultValue = 10*weight+6.25*height+5*age+5
                result.text = String(describing: resultValue)
                print(resultValue)
            }
        }
    }
    }

