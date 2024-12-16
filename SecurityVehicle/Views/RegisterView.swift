import SwiftUI

struct RegisterView: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color(red: 215/255, green: 231/255, blue: 250/255) // Light blue background
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Título principal
                Text("NOTELY")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color.black)
                    .padding(.top, 30)
                
                // Subtítulo
                Text("Regístrate en Notely, interactúa con sus funcionalidades y comienza una aventura llena de ideas e imaginación.")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.gray)
                    .padding(.horizontal, 30)
                
                // Campos de texto
                Group {
                    Text("Full Name")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 30)
                    
                    TextField("Salman Khan", text: $fullName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                    
                    Text("Email Address")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 30)
                    
                    TextField("mesalmanwap@gmail.com", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                    
                    Text("Password")
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
                }

                // Botón de registro
                Button(action: {
                    if fullName.isEmpty || email.isEmpty || password.isEmpty {
                        alertMessage = "Por favor, llena todos los campos."
                        showAlert = true
                    } else {
                        alertMessage = "Registro exitoso. ¡Inicia sesión ahora!"
                        showAlert = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }) {
                    Text("Crear cuenta")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 113/255, green: 114/255, blue: 240/255)) // Purple color
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 30)
                }
                .padding(.top, 10)
                
                // Pregunta de navegación
                Text("Already have an account?")
                    .font(.system(size: 14))
                    .foregroundColor(Color.blue)
                    .padding(.top, 10)
                
                Spacer()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Registro"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    RegisterView()
}

