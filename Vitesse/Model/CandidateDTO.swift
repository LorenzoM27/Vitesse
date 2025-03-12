//
//  Candidat.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 08/02/2025.
//


import Foundation


struct CandidateDTO: Identifiable, Decodable {
    let id: UUID
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let note: String?
    let linkedinURL: String?
    let isFavorite: Bool
}
