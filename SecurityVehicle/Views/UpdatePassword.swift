import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSecure: Bool = true
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isLoggedIn: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "note.text") // Icono de notas
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.bottom, 40)
                
                Text("Bienvenido")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.bottom, 20)

                TextField("Username", text: $username)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray.opacity(0.5)))
                    .padding(.bottom, 20)

                HStack {
                    if isSecure {
                        SecureField("Contraseña", text: $password)
                            .textInputAutocapitalization(.never)
                    } else {
                        TextField("Contraseña", text: $password)
                            .textInputAutocapitalization(.never)
                    }
                    Button(action: {
                        isSecure.toggle()
                    }) {
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray.opacity(0.5)))

                NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                    EmptyView()
                }

                Button(action: {
                    if username.isEmpty || password.isEmpty {
                        alertMessage = "Por favor, ingresa tus credenciales."
                        showAlert = true
                    } else if UsuarioManager.shared.validarUsuario(username: username, password: password) {
                        alertMessage = "Inicio de sesión exitoso."
                        showAlert = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isLoggedIn = true
                        }
                    } else {
                        alertMessage = "Credenciales incorrectas. Intenta nuevamente."
                        showAlert = true
                    }
                }) {
                    Text("Iniciar sesión")
                    
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Mensaje"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }

                Spacer()

                HStack {
                    Text("¿No tienes una cuenta?")
                    NavigationLink(destination: RegisterView()) {
                        Text("Regístrate")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                    }
                }
                .padding(.top, 20)
            }
            .padding()
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        }
    }
}



#Preview {
    LoginView()
}
