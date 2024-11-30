//
//  UpdatePassword.swift
//  SecurityVehicle
//
//  Created by DAMII on 30/11/24.
//

import SwiftUI

struct UpdatePassword: View {
    @State private var correo: String = ""
       @State private var nuevaContrasena: String = ""
       @State private var confirmarContrasena: String = ""
       @State private var mostrarNuevaContrasena: Bool = false
       @State private var mostrarConfirmarContrasena: Bool = false
       @State private var mensaje: String = ""
       @State private var mostrarMensaje: Bool = false
       @State private var requisitosCumplidos: [Bool] = [false, false, false]
       @State private var mostrarRequisitos: Bool = false
       @State private var contrasenasCoinciden: Bool = true
       @State private var correoValido: Bool = true
       @State private var correoExistente: Bool = true // Validar si el correo existe
       @Environment(\.presentationMode) var presentationMode // Para regresar al login
       
       var body: some View {
           VStack(spacing: 20) {
               Text("Actualizar Contraseña")
                   .font(.largeTitle)
                   .padding()
               
               VStack(alignment: .leading, spacing: 5) {
                   // Campo de correo electrónico
                   VStack(alignment: .leading, spacing: 5) {
                       TextField("Correo Electrónico", text: $correo)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .onChange(of: correo) { value in
                               validarCorreo(value)
                           }
                       
                       if !correoValido {
                           Text("Correo no válido")
                               .foregroundColor(.red)
                               .font(.caption)
                       }
                       
                       if !correoExistente {
                           Text("Correo no encontrado")
                               .foregroundColor(.red)
                               .font(.caption)
                       }
                   }
                   
                   // Nueva contraseña
                   HStack {
                       if mostrarNuevaContrasena {
                           TextField("Nueva Contraseña", text: $nuevaContrasena)
                               .textFieldStyle(RoundedBorderTextFieldStyle())
                               .onChange(of: nuevaContrasena) { value in
                                   validarNuevaContrasena(value)
                                   validarCoincidenciaContrasenas()
                               }
                       } else {
                           SecureField("Nueva Contraseña", text: $nuevaContrasena)
                               .textFieldStyle(RoundedBorderTextFieldStyle())
                               .onChange(of: nuevaContrasena) { value in
                                   validarNuevaContrasena(value)
                                   validarCoincidenciaContrasenas()
                               }
                       }
                       Button(action: {
                           mostrarNuevaContrasena.toggle()
                       }) {
                           Image(systemName: mostrarNuevaContrasena ? "eye.slash" : "eye")
                       }
                   }
                   
                   // Requisitos de la contraseña
                   if mostrarRequisitos {
                       VStack(alignment: .leading) {
                           Text("Requisitos de la contraseña:")
                               .font(.headline)
                               .padding(.top, 5)
                           
                           Text("• Al menos 8 caracteres")
                               .foregroundColor(requisitosCumplidos[0] ? .green : .red)
                           Text("• Al menos una letra mayúscula")
                               .foregroundColor(requisitosCumplidos[1] ? .green : .red)
                           Text("• Al menos un número")
                               .foregroundColor(requisitosCumplidos[2] ? .green : .red)
                       }
                   }
                   
                   // Confirmar contraseña
                   HStack {
                       if mostrarConfirmarContrasena {
                           TextField("Confirmar Contraseña", text: $confirmarContrasena)
                               .textFieldStyle(RoundedBorderTextFieldStyle())
                               .onChange(of: confirmarContrasena) { _ in
                                   validarCoincidenciaContrasenas()
                               }
                       } else {
                           SecureField("Confirmar Contraseña", text: $confirmarContrasena)
                               .textFieldStyle(RoundedBorderTextFieldStyle())
                               .onChange(of: confirmarContrasena) { _ in
                                   validarCoincidenciaContrasenas()
                               }
                       }
                       Button(action: {
                           mostrarConfirmarContrasena.toggle()
                       }) {
                           Image(systemName: mostrarConfirmarContrasena ? "eye.slash" : "eye")
                       }
                   }
                   
                   // Mostrar mensaje de error si las contraseñas no coinciden
                   if !contrasenasCoinciden {
                       Text("Las contraseñas no coinciden")
                           .foregroundColor(.red)
                           .font(.caption)
                   }
               }
               
               // Botón para actualizar la contraseña
               Button(action: {
                   if correoValido && correoExistente && requisitosCumplidos.allSatisfy({ $0 }) && contrasenasCoinciden {
                       UsuarioManager.shared.actualizarContrasena(correo: correo, nuevaContrasena: nuevaContrasena)
                       mensaje = "Contraseña actualizada con éxito"
                       mostrarMensaje = true
                       // Aquí podemos cerrar la vista de actualización y regresar al login
                       DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                           presentationMode.wrappedValue.dismiss() // Redirige al LoginView
                       }
                   } else {
                       mensaje = "Por favor, completa todos los requisitos."
                       mostrarMensaje = true
                   }
               }) {
                   Text("Actualizar Contraseña")
                       .frame(maxWidth: .infinity)
                       .padding()
                       .background(Color.blue)
                       .foregroundColor(.white)
                       .cornerRadius(10)
               }
               
               // Alertas
               .alert(isPresented: $mostrarMensaje) {
                   Alert(title: Text("Resultado"), message: Text(mensaje), dismissButton: .default(Text("OK")))
               }
               
               Spacer()
           }
           .padding()
       }
       
       func validarNuevaContrasena(_ nuevaContrasena: String) {
           let requisitos = [
               nuevaContrasena.count >= 8,
               nuevaContrasena.rangeOfCharacter(from: .uppercaseLetters) != nil,
               nuevaContrasena.rangeOfCharacter(from: .decimalDigits) != nil
           ]
           requisitosCumplidos = requisitos
           mostrarRequisitos = !nuevaContrasena.isEmpty
       }
       
       func validarCoincidenciaContrasenas() {
           contrasenasCoinciden = nuevaContrasena == confirmarContrasena
       }
       
       func validarCorreo(_ correo: String) {
           let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
           correoValido = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: correo)
           
           if correoValido {
               correoExistente = UsuarioManager.shared.obtenerUsuarioPorCorreo(correo: correo) != nil
           }
       }
   }
#Preview {
    UpdatePassword()
}
