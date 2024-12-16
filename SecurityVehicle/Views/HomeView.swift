import SwiftUI

struct HomeView: View {
    @State private var showLoginView = false
    @State private var showRegisterView = false
    
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
                Image("home")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 400) // Máximo ancho y altura limitada
                    .padding(.top, 50)

                
                // Título principal
                Text("Tus ideas, más seguras que nunca")
                    .font(.title2)
                
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 64 / 255, green: 59 / 255, blue: 54 / 255, opacity: 1)
)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                // Descripción
                Text("Con Notely, tu creatividad está protegida. Almacena, organiza y comparte tus pensamientos con total tranquilidad.")
                    .font(.body)
                    .foregroundColor(Color(red: 89 / 255, green: 85 / 255, blue: 80 / 255, opacity: 1)
)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                // Botón de explorar - Redirige al RegisterView
                Button(action: {
                    showRegisterView = true
                }) {
                    Text("EXPLORA TUS IDEAS")
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 125 / 255, green: 142 / 255, blue: 215 / 255, opacity: 1)
)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white
                                    
) // Botón morado suave
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                }
                .fullScreenCover(isPresented: $showRegisterView) {
                    RegisterView()
                }
                
                // Texto inferior - Redirige al LoginView
                Button(action: {
                    showLoginView = true
                }) {
                    Text("Already have an account?")
                        .font(.footnote)
                        .foregroundColor(Color(red: 125 / 255, green: 142 / 255, blue: 215 / 255, opacity: 1)
) // Mismo color que el botón
                        .padding(.bottom, 30)
                }
                .fullScreenCover(isPresented: $showLoginView) {
                    LoginView()
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
