import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct RegisterView: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var returnLoginView = false

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(red: 215/255, green: 231/255, blue: 250/255)
                .ignoresSafeArea()

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
                Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 20)
                .padding(.bottom, 10)
                
                // Subtítulo
               Text("Regístrate en Notely, interactúa con sus funcionalidades y comienza una aventura llena de ideas e imaginación.")
                   .font(.system(size: 16))
                   .multilineTextAlignment(.center)
                   .foregroundColor(Color.gray)
                   .padding(.horizontal, 30)
                
                Group {
                    Text("Nombre completo")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 30)
                    TextField("Juan Mendoza", text: $fullName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                    
                    Text("Correo electrónico")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 30)
                    TextField("ejemplo@gmail.com", text: $email)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                    
                    Text("Contraseña")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 30)
                    ZStack(alignment: .trailing) {
                        
                        if showPassword {
                            TextField("Contraseña", text: $password)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .padding(.horizontal, 30)
                        } else {
                            SecureField("Contraseña", text: $password)
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
                }
                Button(action: registerUser) {
                    Text("Crear cuenta")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 125 / 255, green: 142 / 255, blue: 215 / 255, opacity: 1))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 30)
                }
                .padding(.top, 10)
                Button(action: {
                    returnLoginView = true
                }) {
                    Text("Regresar al Inicio de Sesión")
                        .font(.footnote)
                        .foregroundColor(Color(red: 125 / 255, green: 142 / 255, blue: 215 / 255))
                        .underline()
                }
                .padding(.bottom, 30)
                .fullScreenCover(isPresented: $returnLoginView) {
                    LoginView()
                }
            }
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Registro"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        } 
        
        
    }

    /// Función para registrar un usuario
    private func registerUser() {
        guard !fullName.isEmpty else {
            alertMessage = "El nombre completo es obligatorio."
            showAlert = true
            return
        }
        
        guard !email.isEmpty else {
            alertMessage = "El correo electrónico es obligatorio."
            showAlert = true
            return
        }
        
        guard !password.isEmpty else {
            alertMessage = "La contraseña es obligatoria."
            showAlert = true
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.alertMessage = "Error al registrar: \(error.localizedDescription)"
                self.showAlert = true
                return
            }
            
            guard let userID = authResult?.user.uid else { return }
            
            // Guardar datos adicionales en Realtime Database
            let ref = Database.database().reference()
            let userObject = [
                "fullName": self.fullName,
                "email": self.email
            ]
            
            ref.child("users").child(userID).setValue(userObject) { error, _ in
                if let error = error {
                    self.alertMessage = "Error al guardar datos: \(error.localizedDescription)"
                    self.showAlert = true
                    return
                }
                self.alertMessage = "Registro exitoso. ¡Inicia sesión ahora!"
                self.showAlert = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
#Preview {
    RegisterView()
}
