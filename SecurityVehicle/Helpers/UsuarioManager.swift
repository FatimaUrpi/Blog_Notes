import Foundation

class UsuarioManager {
    static let shared = UsuarioManager()
           
       private let userDefaultsKey = "usuarios"
       
       // Registrar un usuario
       func registrarUsuario(username: String, password: String, correo: String, nombre: String) {
           var usuarios = obtenerUsuarios()
           let nuevoUsuario = ["username": username, "password": password, "correo": correo, "nombre": nombre]
           usuarios.append(nuevoUsuario)
           UserDefaults.standard.set(usuarios, forKey: userDefaultsKey)
       }
       
       // Función para obtener todos los usuarios almacenados en UserDefaults
       func obtenerUsuarios() -> [[String: String]] {
           if let usuarios = UserDefaults.standard.array(forKey: userDefaultsKey) as? [[String: String]] {
               return usuarios
           }
           return [] // Retorna un array vacío si no existen usuarios
       }
       
       // Función para obtener un usuario por correo
       func obtenerUsuarioPorCorreo(correo: String) -> [String: String]? {
           let usuarios = obtenerUsuarios()
           return usuarios.first { $0["correo"] == correo }
       }
       
       // Función para actualizar la contraseña del usuario en UserDefaults
       func actualizarContrasena(correo: String, nuevaContrasena: String) {
           var usuarios = obtenerUsuarios()
           
           if let index = usuarios.firstIndex(where: { $0["correo"] == correo }) {
               usuarios[index]["password"] = nuevaContrasena
               // Actualizar el valor de usuarios en UserDefaults
               UserDefaults.standard.set(usuarios, forKey: userDefaultsKey)
           }
       }
       
       // Validar si el usuario existe con un nombre de usuario y contraseña
       func validarUsuario(username: String, password: String) -> Bool {
           let usuarios = obtenerUsuarios()
           return usuarios.contains { $0["username"] == username && $0["password"] == password }
       }
   }
