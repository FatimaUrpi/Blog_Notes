//
//  UpdatePassword.swift
//  SecurityVehicle
//
//  Created by DAMII on 30/11/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase


struct UpdatePassword: View {
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        ZStack {
            // Fondo de color
            Color(red: 211 / 255, green: 230 / 255, blue: 249 / 255)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Botón de retorno
                               HStack {

                                   Button(action: {

                                       presentationMode.wrappedValue.dismiss()

                                   }) {

                                       Image(systemName: "chevron.left")

                                           .font(.title)

                                           .foregroundColor(Color(red: 125 / 255, green: 142 / 255, blue: 215 / 255)) // Color del ícono

                                           .padding()

                                   }

                                   .padding(.leading, 20)

                                   

                                   Spacer()

                               }
                
                // Logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 20)
                
                // Título
                Text("Actualizar Contraseña")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 10)
                
               /* Image("update")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 550)
                    .padding(.top, 20)*/
                // Campo de Email
                Group {
                    Text("Email:")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 30)
                    
                    TextField("ejemplo@gmail.com", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .padding(.horizontal, 30)
                }
                
                // Botón para enviar correo de restablecimiento
                Button(action: {
                    sendPasswordReset()
                }) {
                    Text("Enviar Correo de Restablecimiento")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 125 / 255, green: 142 / 255, blue: 215 / 255))
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                }
                
                Spacer() // Añade espacio después del contenido
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Mensaje"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    // Función para enviar correo de restablecimiento
    func sendPasswordReset() {
        guard !email.isEmpty else {
            alertMessage = "Por favor, ingrese su correo electrónico."
            showAlert = true
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                alertMessage = "Error: \(error.localizedDescription)"
            } else {
                alertMessage = "Correo de restablecimiento enviado. Revisa tu bandeja de entrada."
            }
            showAlert = true
        }
    }
}

#Preview {
    UpdatePassword()
}
