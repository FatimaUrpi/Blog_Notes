//
//  Home1View.swift
//  SecurityVehicle
//
//  Created by DAMII on 16/12/24.
//

import SwiftUI

struct Home1View: View {
    @State private var showNoteView = false

    
    var body: some View {
        ZStack {
            // Fondo principal
            Color(red: 211 / 255, green: 230 / 255, blue: 249 / 255, opacity: 1)
 // Color celeste claro
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                
            Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 20)
                    .padding(.top, 20)
                    .padding(.bottom, 100)
                // Imagen superior
                Image("home1")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 400) // Máximo ancho y altura limitada
                    .padding(.top, 50)

                
                // Título principal
                Text("Crea tu primera nota")
                    .font(.title2)
                
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 64 / 255, green: 59 / 255, blue: 54 / 255, opacity: 1)
)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                // Descripción
                Text("Crea una nota sobre lo que quieras (tus pensamientos, alguna historia o ensayo) y compartela con el mundo.")
                    .font(.body)
                    .foregroundColor(Color(red: 89 / 255, green: 85 / 255, blue: 80 / 255, opacity: 1)
)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                // Botón de explorar - Redirige al RegisterView
                Button(action: {
                    showNoteView = true
                }) {
                    Text("Crea una nota")
                        .fontWeight(.bold)
                        .foregroundColor(.white
)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 125 / 255, green: 142 / 255, blue: 215 / 255, opacity: 1)
                                    
) // Botón morado suave
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                        .padding(.bottom, 30)
                }
                .fullScreenCover(isPresented: $showNoteView) {
                    NoteListView()
                }
                
            
            }
        }
    }
}

#Preview {
    Home1View()
}
