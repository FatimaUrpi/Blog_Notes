import SwiftUI

struct NoteListView: View {
    @State private var notes: [Note] = []
    
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
                        notes.remove(atOffsets: indexSet)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Bloc de Notas")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: {
                        NoteDetailView { newNote in
                            notes.append(newNote)
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    NoteListView()
}
