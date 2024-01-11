//
//  TodoViewController.swift
//  dailyPlanner
//
//  Created by 123 on 10.01.2024.
//

import UIKit
//
class TodoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TodoCellDelegate {

   //Ссылка на таблицу задач в интерфейсе
    @IBOutlet weak var tableView: UITableView!
    // Массив с задачами
    var todos: [Todo] = [Todo(name: "Test", isCompleted: false)]
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Назначаем делегатом таблицы сам контроллер
        tableView.delegate = self
        tableView.dataSource = self

        // Загрузить сохраненные данные, если они есть
        if hasSavedTodos() {
            loadTodosFromUserDefaults()
        }
    }
    // Обработка нажатия кнопки "Добавить задачу"
    @IBAction func addTodo(_ sender: Any) {
        // Создаем UIAlertController для отображения диалогового окна
        let alert = UIAlertController(title: "Create todo", message: "", preferredStyle: .alert)
        // Добавляем текстовое поле в диалоговое окно
        alert.addTextField()
        // Получаем текст из текстового поля
        let saveButton = UIAlertAction(title: "Save", style: .default) { _ in
            if let textName = alert.textFields?.first?.text {
                // Создаем новую задачу и добавляем ее в массив
                self.todos.append(Todo(name: textName, isCompleted: false))
                // Обновляем таблицу
                self.tableView.reloadData()

                // Сохранить список задач после добавления новой задачи
                self.saveTodosToUserDefaults()
            }
        }
        alert.addAction(saveButton)
        // Добавляем кнопку "Отмена" и отображаем диалоговое окно на экране
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }

    
    // MARK: - Методы таблицы
    // Количество ячеек в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    // Настройка ячейки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Получаем ячейку из таблицы и получаем задачу для текущей ячейки
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as? TodoTableViewCell else { return UITableViewCell() }
        let todoCell = todos[indexPath.row]
        // Устанавливаем делегата ячейке и обновляем ячейку данными задачи
        cell.delegate = self
        cell.updateCell(with: todoCell)
        return cell
    }
    // Обработка свайпа по ячейке таблицы
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Удаляем задачу из массива и удаляем ячейку из таблицы с анимацией
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            // Сохраняем список задач после удаления задачи
            saveTodosToUserDefaults()
        }
    }
    // Проверка наличия сохраненных задач
    func hasSavedTodos() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: "todos") != nil
    }
    // Обработка нажатия на ячейку
    func cellTapped(cell: TodoTableViewCell) {
        // Обработка нажатия на ячейку
        guard let index = tableView.indexPath(for: cell) else { return }
        // Получаем задачу для ячейки по индексу и изменяем статус выполнения задачи
        let todo = todos[index.row]
        todo.isCompleted.toggle()
        // Обновляем таблицу и сохраняем список задач после изменения статуса
        tableView.reloadData()
        saveTodosToUserDefaults()
    }
    // Сохранение списка задач в UserDefaults
    func saveTodosToUserDefaults() {
        let defaults = UserDefaults.standard
        // Кодируем todos с помощью JSONEncoder и сохраняем в UserDefaults
        if let encodedData = try? JSONEncoder().encode(todos) {
            defaults.set(encodedData, forKey: "todos")
        }
    }
    // Функция для загрузки списка задач из UserDefaults
    func loadTodosFromUserDefaults() {
        let defaults = UserDefaults.standard
        // Проверяем, есть ли данные по ключу "todos" в UserDefaults
        if let encodedData = defaults.data(forKey: "todos") {
            // Если данные есть, декодируем их с помощью JSONDecoder в массив типа [Todo]
            if let decodedTodos = try? JSONDecoder().decode([Todo].self, from: encodedData) {
                // Присваиваем декодированный массив todo, обновляем таблицу
                todos = decodedTodos
                tableView.reloadData()
            }
        }
    }
}
//var todos: [Todo] = [Todo(name: "Test", isCompleted: false)]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//        loadTodosFromUserDefaults()
//
//
//    }
//
//    @IBAction func addTodo(_ sender: Any) {
//
//        let alert = UIAlertController(title: "Create todo", message: "", preferredStyle: .alert)
//        alert.addTextField()
//        let saveButton = UIAlertAction(title: "Save", style: .default) { _ in
//            if let textName = alert.textFields?.first?.text {
//                self.todos.append(Todo(name: textName, isCompleted: false))
//                self.tableView.reloadData()
//            }
//        }
//        alert.addAction(saveButton)
//        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
//        alert.addAction(cancelButton)
//
//        present(alert, animated: true)
//    }
//
//    // MARK: - Table View Methods
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return todos.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as? TodoTableViewCell else { return UITableViewCell() }
//        let todoCell = todos[indexPath.row]
//        cell.delegate = self
//        cell.updateCell(with: todoCell)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            todos.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
//
//    func cellTapped(cell: TodoTableViewCell) {
//        guard let index = tableView.indexPath(for: cell) else { return }
//        let todo = todos[index.row]
//        todo.isCompleted.toggle()
//        tableView.reloadData()
//    }
//    func saveTodosToUserDefaults() {
//        let defaults = UserDefaults.standard
//        let encodedData = try? JSONEncoder().encode(todos)
//        defaults.set(encodedData, forKey: "todos")
//    }
//
//    func loadTodosFromUserDefaults() {
//        let defaults = UserDefaults.standard
//        if let encodedData = defaults.data(forKey: "todos") {
//            if let decodedTodos = try? JSONDecoder().decode([Todo].self, from: encodedData) {
//                todos = decodedTodos
//                tableView.reloadData()
//            }
//        }
//    }
//}
//
