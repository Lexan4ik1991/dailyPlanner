//
//  NoteViewController.swift
//  dailyPlanner
//
//  Created by 123 on 12.01.2024.
//
import CoreData
import UIKit

class NoteViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    // Текущая заметка
    var note: Note?
    // Менеджер базы данных
    let databaseManager = DatabaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Если заметка существует, отображаем ее название в поле для ввода текста
        if let note = note {
            textView.text = note.name
            print(note)
        }
    }
    // Обработчик нажатия на кнопку сохранения
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        print("Button Tapped")
        // Если заметка существует, обновляем ее название и сохраняем в базу данных
        if var note = note {
            note.name = textView.text ?? ""
            databaseManager.addNote(note: note)
        }
    }
    // Вызывается перед закрытием экрана
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Если заметка существует, обновляем ее название и сохраняем в базу данных
        if var note = note {
            note.name = textView.text ?? ""
            databaseManager.addNote(note: note)
        }
    }
}
