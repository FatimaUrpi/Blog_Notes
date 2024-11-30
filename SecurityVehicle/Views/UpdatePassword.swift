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

       var body: some View {
           VStack(spacing: 20) {
               Text("Actualizar Contraseña")
                   .font(.largeTitle)
                   .padding()

               // Campo de correo
               TextField("Correo Electrónico", text: $correo)
                   .textFieldStyle(RoundedBorderTextFieldStyle())
                   .padding(.horizontal)

               // Campo de nueva contraseña con botón de visibilidad
               HStack {
                   if mostrarNuevaContrasena {
                       TextField("Nueva Contraseña", text: $nuevaContrasena)
                   } else {
                       SecureField("Nueva Contraseña", text: $nuevaContrasena)
                   }
                   Button(action: {
                       mostrarNuevaContrasena.toggle()
                   }) {
                       Image(systemName: mostrarNuevaContrasena ? "eye.slash" : "eye")
                           .foregroundColor(.gray)
                   }
               }
               .textFieldStyle(RoundedBorderTextFieldStyle())
               .padding(.horizontal)

               // Campo de confirmar contraseña con botón de visibilidad
               HStack {
                   if mostrarConfirmarContrasena {
                       TextField("Confirmar Contraseña", text: $confirmarContrasena)
                   } else {
                       SecureField("Confirmar Contraseña", text: $confirmarContrasena)
                   }
                   Button(action: {
                       mostrarConfirmarContrasena.toggle()
                   }) {
                       Image(systemName: mostrarConfirmarContrasena ? "eye.slash" : "eye")
                           .foregroundColor(.gray)
                   }
               }
               .textFieldStyle(RoundedBorderTextFieldStyle())
               .padding(.horizontal)

               // Botón para actualizar contraseña
               Button(action: {
                   // Acción de actualización de contraseña
                   mensaje = "Contraseña actualizada con éxito."
                   mostrarMensaje = true
               }) {
                   Text("Actualizar Contraseña")
                       .frame(maxWidth: .infinity)
                       .padding()
                       .background(Color.blue)
                       .foregroundColor(.white)
                       .cornerRadius(10)
               }
               .padding(.horizontal)

               // Mostrar mensaje de éxito o error
               if mostrarMensaje {
                   Text(mensaje)
                       .foregroundColor(.green)
                       .padding()
               }

               Spacer()
           }
           .padding()
       }
   }

   #Preview {
       UpdatePassword()
   }
