//
//  DatabaseManager.swift
//  dailyPlanner
//
//  Created by 123 on 12.01.2024.
//
import CoreData
import UIKit

protocol DatabaseCacheProtocol {
    func addNote(note: Note)
    func fetchNote() -> [Note]
}

class DatabaseManager: DatabaseCacheProtocol {
    // создание контейнера для хранения данных
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AppModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Error setting up Core Data: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    // Сохранение данных в контексте
    private func save() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    // Добавление заметки в базу данных
    func addNote(note: Note) {
        // Поиск заметки по уникальному идентификатору
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [note.id])
        
        let result = try? persistentContainer.viewContext.fetch(fetchRequest)
        // Проверка, что заметка с таким идентификатором уже существует
        guard result?.first == nil else {
            return
        }
        // Создание новой заметки в контексте
        let noteModel = NoteEntity(context: persistentContainer.viewContext)
        noteModel.id = Int64(note.id)
        noteModel.name = note.name
        
        save()
    }
    // Получение всех заметок из базы данных
    func fetchNote() -> [Note] {
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        
        guard let notes = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return []
        }
        
        var newNotes: [Note] = []
        // Преобразование заметок из формата NSManagedObject в формат Note
        for note in notes {
            newNotes.append(Note(name: note.name ?? "", id: Int(note.id)))
        }
        
        return newNotes
    }
}
