import Foundation

class UsuarioManager {
    static let shared = UsuarioManager()
    private let userDefaultsKey = "usuariosRegistrados"

    private init() {}

    func registrarUsuario(username: String, password: String, correo: String, nombre: String) {
        var usuarios = obtenerUsuarios()
        let nuevoUsuario = ["username": username, "password": password, "correo": correo, "nombre": nombre]
        usuarios.append(nuevoUsuario)
        UserDefaults.standard.set(usuarios, forKey: userDefaultsKey)
    }

    func obtenerUsuarios() -> [[String: String]] {
        return UserDefaults.standard.array(forKey: userDefaultsKey) as? [[String: String]] ?? []
    }

    func validarUsuario(username: String, password: String) -> Bool {
        let usuarios = obtenerUsuarios()
        return usuarios.contains { $0["username"] == username && $0["password"] == password }
    }
}
