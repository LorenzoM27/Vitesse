//
//  Candidat.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 08/02/2025.
//


import Foundation


struct CandidateDto: Identifiable, Decodable {
    let id: UUID
    let firstName: String
    let lastName: String
    let email: String
    var phone: String?
    var note: String?
    var linkedinURL: String?
    var isFavorite: Bool
}
