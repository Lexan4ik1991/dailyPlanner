//
//  NoteViewController.swift
//  dailyPlanner
//
//  Created by 123 on 11.01.2024.
//

import Foundation
import UIKit
//import MySQL
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class NoteViewContriller : UIViewController{
    
   
    @IBOutlet weak var textView: UITextView!
    // Функция сохранения textView в базу данных MySQL
//    func saveTextViewToDatabase() {
//        // Установка соединения с базой данных
//        let mysql = MySQL()
//
//        let connecion = mysql.connect(host: "localhost", user: "root", password: "", db: "mydatabase")
//        guard connecion else {
//            print("Ошибка соединения с базой данных: \(mysql.errorMessage())")
//            return
//        }
//
//        // Подготовка SQL запроса
//        let noteText = textView.text
//
//        let insertQuery = "INSERT INTO notes (text) VALUES ('\(noteText)')"
//
//        // Выполнение SQL запроса
//        let success = mysql.query(statement: insertQuery)
//        guard success else {
//            print("Ошибка выполнения запроса: \(mysql.errorMessage())")
//            return
//        }
//
//        // Закрытие соединения с базой данных
//        mysql.close()
//    }
//
}
