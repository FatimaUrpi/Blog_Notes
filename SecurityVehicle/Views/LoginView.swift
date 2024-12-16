import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var showLoginView = false
    @State private var showRegisterView = false
    @State private var showUpdatePasswordView = false // Añadir esta variable
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @State private var errorMessage: String?
    @State private var isAuthenticated = false
    
    var body: some View {
        if isAuthenticated {
            HomeView() // Redirige a la pantalla principal al autenticar
        } else {
            ZStack {
                // Fondo principal
                Color(red: 211 / 255, green: 230 / 255, blue: 249 / 255, opacity: 1)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 20)
                        .padding(.top, 20)
               
                    
                    Text("Iniciar Sesión")
                        .font(.title)
                        .bold()
                    
                    Text("Email:")
                        .font(.system(size: 15, weight: .semibold))
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
                    HStack {
                        Text("Password:")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 29)
                        
                        Spacer() // Esto empuja el segundo texto hacia la derecha
                        
                        Text("Olvidaste tu contraseña?")
                            .font(.footnote)
                            .foregroundColor(Color(red: 125 / 255, green: 142 / 255, blue: 215 / 255, opacity: 1))
                            .underline()
                            .padding(.trailing, 26)
                            .onTapGesture {
                                showUpdatePasswordView = true // Mostrar UpdatePasswordView
                            }
                    }
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
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 125 / 255, green: 142 / 255, blue: 215 / 255, opacity: 1)) // Botón morado suave
                            .cornerRadius(10)
                            .padding(.horizontal, 50)
                            .padding(.top, 5)
                        
                    }
                    
                    
                    
                    Button(action: {
                        showRegisterView = true // Cambiar a showRegisterView
                    }) {
                        Text("Registrate")
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 125 / 255, green: 142 / 255, blue: 215 / 255, opacity: 1)) // Color del texto
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.clear) // Fondo transparente
                            .cornerRadius(10)
                            .overlay( // Borde de 1px
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(red: 125 / 255, green: 142 / 255, blue: 215 / 255, opacity: 1), lineWidth: 1)
                            )
                            .padding(.horizontal, 50)
                            .padding(.bottom, 30)
                    }
                    
                    
                    
                }
                .padding(.bottom, 30)
                .padding()
                // Navegación a las vistas de "UpdatePassword" y "RegisterView"
                .fullScreenCover(isPresented: $showRegisterView) {
                    RegisterView() // Mostrar RegisterView
                }
                .fullScreenCover(isPresented: $showUpdatePasswordView) {
                    UpdatePassword() // Mostrar UpdatePasswordView
                }
            }
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
    
    // Función auxiliar para errores
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
