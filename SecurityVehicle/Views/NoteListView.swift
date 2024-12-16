import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct NoteListView: View {
    @State private var notes: [Note] = []
    private var databaseRef = Database.database().reference().child("notes")

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(notes) { note in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(note.title)
                                .font(.headline)
                                .lineLimit(1)
                                .padding(.top, 5)
                            
                            Text(note.content)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                            
                            HStack {
                                Spacer()
                                
                                // Botón para editar la nota
                                Button(action: {
                                    editNote(note)
                                }) {
                                    Image(systemName: "pencil.circle")
                                        .font(.title3)
                                        .foregroundColor(.blue)
                                }
                                
                                // Botón para eliminar la nota
                                Button(action: {
                                    deleteNoteFromFirebase(note)
                                }) {
                                    Image(systemName: "trash.circle")
                                        .font(.title3)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.1)))
                        .onTapGesture {
                            editNote(note) // Editar al tocar la nota
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Bloc de Notas")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: {
                        NoteDetailView { newNote in
                            saveNoteToFirebase(newNote)
                            notes.append(newNote)
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            fetchNotes()
        }
    }

    // MARK: - Funciones de Firebase
    
    private func fetchNotes() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let userNotesRef = databaseRef.child(userId)
        
        userNotesRef.observe(.value) { snapshot in
            var fetchedNotes: [Note] = []
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let value = childSnapshot.value as? [String: Any] {
                    let note = Note(snapshot: value, id: childSnapshot.key)
                    fetchedNotes.append(note)
                }
            }
            self.notes = fetchedNotes
        }
    }
    
    private func saveNoteToFirebase(_ note: Note) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let userNotesRef = databaseRef.child(userId).childByAutoId()
        userNotesRef.setValue(note.toDictionary())
    }
    
    private func updateNoteInFirebase(_ note: Note) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        databaseRef.child(userId).child(note.id).updateChildValues(note.toDictionary())
    }
    
    private func deleteNoteFromFirebase(_ note: Note) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        databaseRef.child(userId).child(note.id).removeValue()
        notes.removeAll { $0.id == note.id }
    }
    
    private func editNote(_ note: Note) {
        // Navega a la vista de edición de la nota
        NavigationStack {
            NoteDetailView(existingNote: note) { updatedNote in
                if let index = notes.firstIndex(where: { $0.id == note.id }) {
                    notes[index] = updatedNote
                    updateNoteInFirebase(updatedNote)
                }
            }
        }
    }
}
#Preview {
    NoteListView()
}
