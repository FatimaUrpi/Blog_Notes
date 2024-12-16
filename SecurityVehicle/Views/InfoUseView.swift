import SwiftUI

struct InfoUseView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Encabezado
            VStack(spacing: 8) {
                Text("NOTELY")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color.black)
                
                // Imagen del usuario
                Image("Profile") // Reemplaza con tu asset de imagen
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding(4)
                    .background(Circle().fill(Color.brown.opacity(0.2)))
                
                // Nombre y ubicación del usuario
                Text("Shambhavi Mishra")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("Lucknow, India")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            // Lista de opciones
            VStack(spacing: 16) {
                InfoRow(icon: "crown", title: "Buy Premium")
                InfoRow(icon: "pencil", title: "Edit Profile")
                InfoRow(icon: "paintpalette", title: "App Theme")
                InfoRow(icon: "bell", title: "Notifications")
                InfoRow(icon: "lock.shield", title: "Security")
                InfoRow(icon: "arrow.right.square", title: "Log Out")
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding(.top, 40)
        .background(Color(red: 0.84, green: 0.93, blue: 1.0)) // Color de fondo azul claro
        .edgesIgnoringSafeArea(.all)
    }
}

struct InfoRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .font(.system(size: 24))
                .frame(width: 36, height: 36)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 1)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    InfoUseView()
}

