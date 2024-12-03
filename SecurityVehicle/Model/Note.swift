//
//  Note.swift
//  SecurityVehicle
//
//  Created by DAMII on 30/11/24.
//

import Foundation


struct Note: Identifiable, Codable {
    let id: String
    var title: String
    var content: String
    var category: String

    // Inicializador para convertir datos de Firebase en Note
    init(id: String, title: String, content: String, category: String) {
        self.id = id
        self.title = title
        self.content = content
        self.category = category
    }

    // Inicializador vacío para Firebase
    init(snapshot: [String: Any], id: String) {
        self.id = id
        self.title = snapshot["title"] as? String ?? "Sin título"
        self.content = snapshot["content"] as? String ?? "Sin contenido"
        self.category = snapshot["category"] as? String ?? "Sin categoría"
    }

    // Convierte la nota en un diccionario para Firebase
    func toDictionary() -> [String: Any] {
        return [
            "title": title,
            "content": content,
            "category": category
        ]
    }
    
    
}

extension Note {
    func withUpdatedContent(title: String, content: String, category: String) -> Note {
        return Note(id: self.id, title: title, content: content, category: category)
    }
}

