
//
//  Usuario.swift
//  SecurityVehicle
//
//  Created by DAMII on 30/11/24.
//

import Foundation
import CoreData

class Usuario: NSManagedObject, Identifiable {
    @NSManaged var idUsuario: Int
    @NSManaged var username: String?
    @NSManaged var password: String?
    @NSManaged var correo: String?
    @NSManaged var nombre: String?
}


