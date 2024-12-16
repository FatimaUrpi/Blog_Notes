//
//  LoginView.swift
//  SecurityVehicle
//
//  Created by DAMII on 16/12/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var showLoginView = false
    @State private var showRegisterView = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @State private var errorMessage: String?
    @State private var isAuthenticated = false
    
    var body: some View {
        if isAuthenticated {
            Home1View() // Redirige a la pantalla principal al autenticar
        } else {
            ZStack {
                // Fondo principal
                Color(red: 211 / 255, green: 230 / 255, blue: 249 / 255, opacity: 1)
                // Color celeste claro
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 20)
                        .padding(.top, 20)
                        .padding(.bottom, 100)
                    
                    
                    Text("Iniciar Sesión")
                        .font(.title)
                        .bold()
                    // Subtítulo
                    Text("Crea una cuenta usando tu correo electrónico y contraseña")
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.gray)
                        .padding(.horizontal, 30)
                    
                    Text("Email:")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 30)
                    
                    TextField("ejemplo@gmail.com", text: $email)
                        .padding()
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        .autocapitalization(.none)
                    Text("Password:")
                    
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 30)
                    
                    ZStack(alignment: .trailing) {
                        if showPassword {
                            TextField("##########", text: $password)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .padding(.horizontal, 30)
                        } else {
                            SecureField("##########", text: $password)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .padding(.horizontal, 30)
                        }
                        
                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 40)
                        }
                    }
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    // Imagen superior
                    Image("login")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 400) // Máximo ancho y altura limitada
                        .padding(.top, 5)
                        .padding(.bottom, -25)
                    
                    Button(action: {
                        loginUser()
                    }) {
                        Text("Iniciar Sesión")
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
                    .fullScreenCover(isPresented: $showLoginView) {
                        LoginView()
                    }
                    
                    HStack {
                        Text("¿Todavía no tienes una cuenta?")
                            .font(.footnote)
                            .foregroundColor(.black) // Color normal para el texto
                        
                        Button(action: {
                            showRegisterView = true
                        }) {
                            Text("Regístrate")
                                .font(.footnote)
                                .foregroundColor(Color(red: 125 / 255, green: 142 / 255, blue: 215 / 255, opacity: 1)) // Color que deseas para el enlace
                                .underline() // Agregar subrayado para indicar que es un enlace
                        }
                    }
                    .padding(.bottom, 30)
                    .fullScreenCover(isPresented: $showRegisterView) {
                        RegisterView()
                    }
                }
                .padding()
            }
        }}
    
    // Función para iniciar sesión
    private func loginUser() {
        // Intentar iniciar sesión con Firebase
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
