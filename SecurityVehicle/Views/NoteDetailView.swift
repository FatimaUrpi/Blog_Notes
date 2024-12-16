import SwiftUI

struct NoteDetailView: View {
    @State var title: String = ""
    @State var content: String = ""
    @State var category: String = "General" // Valor predeterminado
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
                
                Picker("Categoría", selection: $category) {
                    Text("General").tag("General")
                    Text("Holi").tag("Holi")
                    Text("Trabajo").tag("Trabajo")
                    Text("Personal").tag("Personal")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .onAppear {
                if let note = existingNote {
                    title = note.title
                    content = note.content
                    category = note.category
                }
            }
            .navigationTitle(existingNote == nil ? "Nueva Nota" : "Editar Nota")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Guardar") {
                        var note: Note
                        if let existingNote = existingNote {
                            note = existingNote.withUpdatedContent(title: title, content: content, category: category)
                        } else {
                            note = Note(id: UUID().uuidString, title: title, content: content, category: category)
                        }
                        onSave(note)
                        dismiss()

                    }
                    .disabled(title.isEmpty || content.isEmpty)
                }
            }
        }
    }
}

