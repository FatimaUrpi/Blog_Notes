//
//  Note.swift
//  SecurityVehicle
//
//  Created by DAMII on 30/11/24.
//

import Foundation


struct Note: Identifiable {
    let id: UUID = UUID()
    var title: String
    var content: String


    //let idUsuario: Int  // Asociamos la nota con un usuario
  
}

