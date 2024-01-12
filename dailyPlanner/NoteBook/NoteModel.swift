//
//  Note.swift
//  dailyPlanner
//
//  Created by 123 on 12.01.2024.
//

import Foundation
import CoreData

//class Note: NSManagedObject {
//    @NSManaged var content: String
//}
//class Note{
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//}
struct NoteModel: Decodable {
    var note: [Note]
}

struct Note: Decodable {
    var name: String
    var id: Int
}
