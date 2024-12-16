import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct NoteListView: View {
    @State private var notes: [Note] = []
    private var databaseRef = Database.database().reference().child("notes")
    
    // Define el diseño de la cuadrícula (dos columnas en este caso)
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        
        NavigationStack {
            
            // Usamos LazyVGrid en lugar de List
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {  // Ajusta el valor de 'spacing' para reducir el espacio entre los bloques
                    ForEach(notes) { note in
                        NavigationLink(destination: {
                            NoteDetailView(existingNote: note) { updatedNote in
                                if let index = notes.firstIndex(where: { $0.id == note.id }) {
                                    notes[index] = updatedNote
                                    updateNoteInFirebase(updatedNote) // Actualiza la nota en Firebase
                                }
                            }
                        }) {
                            // Diseño de cada bloque cuadrado que se ajusta al tamaño del contenido
                            VStack {
                                Text(note.title)
                                    .font(.headline)
                                    .padding(.top, 5)
                                Text(note.content)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                                    .padding(.horizontal, 5)
                                Spacer()
                            }
                            .padding([.top, .bottom], 8)  // Reduce el padding superior e inferior dentro de cada bloque
                            .padding([.leading, .trailing], 10)  // Ajusta el padding lateral
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.1)))
                            .fixedSize(horizontal: false, vertical: true)  // Asegura que el bloque se ajuste al contenido
                        }
                    }
                    .onDelete { indexSet in
                        deleteNoteFromFirebase(at: indexSet) // Elimina la nota en Firebase
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Bloc de Notas")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: {
                        NoteDetailView { newNote in
                            saveNoteToFirebase(newNote) // Guarda la nueva nota en Firebase
                            notes.append(newNote)
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            fetchNotes() // Carga las notas al aparecer
        }
    }
    
    // MARK: - Firebase Integration Functions
    
    /// Carga las notas desde Firebase
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


    
    /// Guarda una nueva nota en Firebase
    private func saveNoteToFirebase(_ note: Note) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let userNotesRef = databaseRef.child(userId).childByAutoId()
        userNotesRef.setValue(note.toDictionary())
    }

    
    /// Actualiza una nota existente en Firebase
    private func updateNoteInFirebase(_ note: Note) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        databaseRef.child(userId).child(note.id).updateChildValues(note.toDictionary())
    }

    
    /// Elimina una nota en Firebase
    private func deleteNoteFromFirebase(at offsets: IndexSet) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        for index in offsets {
            let note = notes[index]
            databaseRef.child(userId).child(note.id).removeValue()
        }
        notes.remove(atOffsets: offsets)
    }

}

#Preview {
    NoteListView()
}
