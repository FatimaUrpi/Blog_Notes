import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSecure: Bool = true

    var body: some View {
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

            TextField("Correo electrónico", text: $username)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray.opacity(0.5)))
                .padding(.bottom, 20)

            HStack {
                if isSecure {
                    SecureField("Contraseña", text: $password)
                } else {
                    TextField("Contraseña", text: $password)
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

            Button(action: {
                // Lógica de inicio de sesión
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

            Spacer()

            HStack {
                Text("¿No tienes una cuenta?")
                Button(action: {
                    // Navegar a la pantalla de registro
                }) {
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



#Preview {
    LoginView()
}
