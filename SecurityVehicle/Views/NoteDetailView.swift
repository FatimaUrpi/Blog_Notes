//
//  NoteDetailView.swift
//  SecurityVehicle
//
//  Created by DAMII on 30/11/24.
//

import SwiftUI

struct NoteDetailView: View {
    @State var title: String = ""
    @State var content: String = ""
    @Environment(\.dismiss) var dismiss
    let onSave: (Note) -> Void
    var existingNote: Note?

    var body: some View {
        NavigationStack {
            Form {
                TextField("Título", text: $title)
                    .textFieldStyle(.roundedBorder)
                
                TextEditor(text: $content)
                    .frame(height: 200)
                    .border(Color.gray.opacity(0.5), width: 1)
                    .cornerRadius(8)
            }
            .onAppear {
                if let note = existingNote {
                    title = note.title
                    content = note.content
                }
            }
            .navigationTitle(existingNote == nil ? "Nueva Nota" : "Editar Nota")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Guardar") {
                        let note = Note(title: title, content: content)
                        onSave(note)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NoteDetailView(onSave: { _ in })
}

