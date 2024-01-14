//
//  TodoViewControllerTests.swift
//  dailyPlannerTests
//
//  Created by 123 on 14.01.2024.
//

import XCTest
@testable import dailyPlanner
final class TodoViewControllerTests: XCTestCase {
    
    var todoVC: TodoViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        todoVC = storyboard.instantiateViewController(withIdentifier: "TodoViewController") as? TodoViewController
        todoVC.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        todoVC = nil
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(todoVC.tableView.delegate)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(todoVC.tableView.dataSource)
    }
    
    func testTableViewNumberOfRowsInSection() {
        todoVC.todos = [Todo(name: "Test Todo", isCompleted: false)]
        
        let numberOfRows = todoVC.tableView(todoVC.tableView, numberOfRowsInSection: 0)
        
        XCTAssertEqual(numberOfRows, todoVC.todos.count)
    }
    
    func testTableViewCellForRowAtIndexPathReturnsCell() {
        todoVC.todos = [Todo(name: "Test Todo", isCompleted: false)]
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = todoVC.tableView(todoVC.tableView, cellForRowAt: indexPath)
        
        XCTAssertTrue(cell is TodoTableViewCell)
    }
    
    func testSaveTodosToUserDefaults() {
        todoVC.todos = [Todo(name: "Test Todo", isCompleted: false)]
        
        todoVC.saveTodosToUserDefaults()
        
        let defaults = UserDefaults.standard
        let savedTodos = defaults.object(forKey: "todos") as? Data
        
        XCTAssertNotNil(savedTodos)
    }
    
    func testLoadTodosFromUserDefaults() {
        todoVC.todos = [Todo(name: "Test Todo", isCompleted: false)]
        
        todoVC.saveTodosToUserDefaults()
        todoVC.todos = []
        todoVC.loadTodosFromUserDefaults()
        
        XCTAssertEqual(todoVC.todos.count, 1)
    }
    

}
