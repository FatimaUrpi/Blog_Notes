import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var nombre: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Regístrate")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            TextField("Correo electrónico", text: $email)
                .padding()
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray.opacity(0.5)))
                .padding(.bottom, 10)

            TextField("Nombre", text: $nombre)
                .padding()
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray.opacity(0.5)))
                .padding(.bottom, 10)

            TextField("Usuario", text: $username)
                .padding()
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray.opacity(0.5)))
                .padding(.bottom, 10)

            SecureField("Contraseña", text: $password)
                .padding()
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray.opacity(0.5)))
                .padding(.bottom, 20)

            Button(action: {
                if email.isEmpty || username.isEmpty || password.isEmpty || nombre.isEmpty {
                    alertMessage = "Por favor, llena todos los campos."
                    showAlert = true
                } else {
                    UsuarioManager.shared.registrarUsuario(username: username, password: password, correo: email, nombre: nombre)
                    alertMessage = "Registro exitoso. ¡Inicia sesión ahora!"
                    showAlert = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }) {
                Text("Registrar")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Registro"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    RegisterView()
}
