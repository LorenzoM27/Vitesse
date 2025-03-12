//
//  Candidate.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 26/02/2025.
//

import Foundation

struct Candidate: Identifiable {
    let id: UUID
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var note: String?
    var linkedinURL: String?
    var isFavorite: Bool
    
    
    init(from dto: CandidateDTO) {
        self.id = dto.id
        self.firstName = dto.firstName
        self.lastName = dto.lastName
        self.email = dto.email
        self.phone = dto.phone
        self.note = dto.note
        self.linkedinURL = dto.linkedinURL
        self.isFavorite = dto.isFavorite
    }
}

