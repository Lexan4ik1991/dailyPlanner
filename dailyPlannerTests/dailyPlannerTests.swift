//
//  dailyPlannerTests.swift
//  dailyPlannerTests
//
//  Created by 123 on 14.01.2024.
//

import XCTest
@testable import dailyPlanner
final class CalculatorViewControllerTests: XCTestCase {
    
    var calculatorVC: CalculatorViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        calculatorVC = storyboard.instantiateViewController(withIdentifier: "CalculatorViewController") as? CalculatorViewController
        
        calculatorVC.loadViewIfNeeded()
    }
    
    func testNumbersButtonPressed() {
        let numberButton = UIButton()
        numberButton.tag = 1
        
        calculatorVC.numbers(numberButton)
        
        XCTAssertEqual(calculatorVC.label?.text, "0")
        XCTAssertEqual(calculatorVC.numberOnScreen, 0)
        XCTAssertFalse(calculatorVC.performingMath)
        
        calculatorVC.label?.text = "5"
        calculatorVC.numberOnScreen = 5
        
        calculatorVC.performingMath = true
        calculatorVC.numbers(numberButton)
        
        XCTAssertEqual(calculatorVC.label?.text, "0")
        XCTAssertEqual(calculatorVC.numberOnScreen, 0)
        XCTAssertFalse(calculatorVC.performingMath)
    }
    
    func testMathOperationButtonPressed() {
        let operationButton = UIButton()
        
        // Test addition
        operationButton.tag = 13
        calculatorVC.label?.text = "5"
        calculatorVC.previousNumber = 5
        
        calculatorVC.buttons(operationButton)
        
        XCTAssertEqual(calculatorVC.label?.text, "+")
        XCTAssertEqual(calculatorVC.operation, .add)
        XCTAssertTrue(calculatorVC.performingMath)
        
        // Test subtraction
        operationButton.tag = 14
        calculatorVC.label?.text = "10"
        calculatorVC.previousNumber = 10
        
        calculatorVC.buttons(operationButton)
        
        XCTAssertEqual(calculatorVC.label?.text, "-")
        XCTAssertEqual(calculatorVC.operation, .subtract)
        XCTAssertTrue(calculatorVC.performingMath)
        
        // Test multiplication
        operationButton.tag = 15
        calculatorVC.label?.text = "2"
        calculatorVC.previousNumber = 2
        
        calculatorVC.buttons(operationButton)
        
        XCTAssertEqual(calculatorVC.label?.text, "x")
        XCTAssertEqual(calculatorVC.operation, .multiply)
        XCTAssertTrue(calculatorVC.performingMath)
        
        // Test division
        operationButton.tag = 16
        calculatorVC.label?.text = "8"
        calculatorVC.previousNumber = 8
        
        calculatorVC.buttons(operationButton)
        
        XCTAssertEqual(calculatorVC.label?.text, "/")
        XCTAssertEqual(calculatorVC.operation, .divide)
        XCTAssertTrue(calculatorVC.performingMath)
    }
    
    func testEqualButtonPressed() {
        let equalButton = UIButton()
        equalButton.tag = 12
        
        // Test division by zero
        calculatorVC.operation = .divide
        calculatorVC.numberOnScreen = 0
        
        calculatorVC.buttons(equalButton)
        
        XCTAssertEqual(calculatorVC.label?.text, "Enter number")
        
        // Test division
        calculatorVC.operation = .divide
        calculatorVC.numberOnScreen = 2
        
        calculatorVC.buttons(equalButton)
        
        XCTAssertEqual(calculatorVC.label?.text, "0.0")
        
        // Test multiplication
        calculatorVC.operation = .multiply
        calculatorVC.numberOnScreen = 3
        
        calculatorVC.buttons(equalButton)
        
        XCTAssertEqual(calculatorVC.label?.text, "0.0")
        
        // Test subtraction
        calculatorVC.operation = .subtract
        calculatorVC.numberOnScreen = 4
        
        calculatorVC.buttons(equalButton)
        
        XCTAssertEqual(calculatorVC.label?.text, "-4.0")
        
        // Test addition
        calculatorVC.operation = .add
        calculatorVC.numberOnScreen = 5
        
        calculatorVC.buttons(equalButton)
        
        XCTAssertEqual(calculatorVC.label?.text, "5.0")
    }
    
    func testClearButtonPressed() {
        let clearButton = UIButton()
        clearButton.tag = 11
        
        calculatorVC.label?.text = "10"
        calculatorVC.previousNumber = 10
        calculatorVC.numberOnScreen = 5
        calculatorVC.operation = .add
        
        calculatorVC.buttons(clearButton)
        
        XCTAssertEqual(calculatorVC.label?.text, "")
        XCTAssertEqual(calculatorVC.previousNumber, 0)
        XCTAssertEqual(calculatorVC.numberOnScreen, 0)
        XCTAssertNil(calculatorVC.operation)
    }
    
    override func tearDown() {
        calculatorVC = nil
        super.tearDown()
    }
    
}
