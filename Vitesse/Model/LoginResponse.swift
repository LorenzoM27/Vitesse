//
//  LoginResponse.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 05/02/2025.
//

import Foundation


struct LoginResponse: Decodable {
    let token: String
    let isAdmin: Bool
}
