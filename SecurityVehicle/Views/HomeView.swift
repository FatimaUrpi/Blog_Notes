import SwiftUI

import SwiftUI

struct HomeView: View {
    @State private var showLoginView = false
    
    var body: some View {
        ZStack {
            // Fondo colorido
            Color.blue.edgesIgnoringSafeArea(.all)

            // Contenedor principal
            VStack {
                Image("notasPrincipal") // Asegúrate de tener una imagen llamada "notebook" en tus assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding(.top, 80)

                // Título
                Text("Descubre Notas App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)

                // Descripción
                Text("Organiza tus pensamientos y tareas de manera fácil y eficiente.")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.top, 10)

                Spacer()
                
                /*NavigationLink(destination: LoginView()) {
                 LoginView()
             }*/
                // Botón de inicio
                Button(action: {
                    showLoginView = true
                }) {
                    Text("Comenzar")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, 40)
            }
            .padding()
            .background(Color.white.opacity(0.4).cornerRadius(20))
            .shadow(radius: 10)
            .padding(.horizontal, 20)
        }
        .fullScreenCover(isPresented: $showLoginView) {LoginView()}
    }
}

#Preview {
    HomeView()
}

