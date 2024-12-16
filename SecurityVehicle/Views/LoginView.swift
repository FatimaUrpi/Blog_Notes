//
//  LoginView.swift
//  SecurityVehicle
//
//  Created by DAMII on 16/12/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isAuthenticated = false

    var body: some View {
        if isAuthenticated {
            HomeView() // Redirige a la pantalla principal al autenticar
        } else {
            VStack(spacing: 20) {
                Text("Iniciar Sesión")
                    .font(.largeTitle)
                    .bold()

                TextField("Correo Electrónico", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Contraseña", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button("Iniciar Sesión") {
                    loginUser()
                }
                .buttonStyle(.borderedProminent)

                Button("Registrarse") {
                    registerUser()
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
    }

    // Función para iniciar sesión
    private func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = handleAuthError(error)
                return
            }
            self.isAuthenticated = true
        }
    }

    // Función para registrar un usuario
    private func registerUser() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = handleAuthError(error)
                return
            }
            self.errorMessage = "Usuario registrado con éxito. Por favor, inicia sesión."
        }
    }
    
    //Función auxiliar para errores
    private func handleAuthError(_ error: Error) -> String {
        let nsError = error as NSError
        switch AuthErrorCode(rawValue: nsError.code) {
        case .invalidEmail:
            return "El correo electrónico no es válido."
        case .emailAlreadyInUse:
            return "El correo ya está en uso."
        case .weakPassword:
            return "La contraseña es demasiado débil."
        case .wrongPassword:
            return "Contraseña incorrecta."
        case .userNotFound:
            return "Usuario no encontrado."
        default:
            return error.localizedDescription
        }
    }
}


#Preview {
    LoginView()
}
