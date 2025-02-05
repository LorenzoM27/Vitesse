//
//  APIEndpoint.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 04/02/2025.
//

import Foundation

enum APIEndpoint {
    case auth(email: String, password: String)
    case register(email: String, password: String, firstName: String, lastName: String)
    case getCandidates
    case getCandidateDetail(candidateId: String)
    case createCandidate(email: String, firstName: String, lastName: String, phone: String?, note: String?, linkedinURL: String?)
    case updateCandidate(candidateId: String, email: String, firstName: String, lastName: String, phone: String?, note: String?, linkedinURL: String?)
    case deleteCandidate(candidateId: String)
    case updateFavoriteStatus(candidateId: String)

    var path: String {
        switch self {
        case .auth:
            return "user/auth"
        case .register:
            return "user/register"
        case .getCandidates:
            return "candidate"
        case .getCandidateDetail(let candidateId):
            return "candidate/\(candidateId)"
        case .createCandidate:
            return "candidate"
        case .updateCandidate(let candidateId, _, _, _, _, _, _):
            return "candidate/\(candidateId)"
        case .deleteCandidate(let candidateId):
            return "candidate/\(candidateId)"
        case .updateFavoriteStatus(let candidateId):
            return "candidate/\(candidateId)/favorite"
        }
    }

    var method: String {
        switch self {
        case .auth, .register, .createCandidate:
            return "POST"
        case .getCandidates, .getCandidateDetail:
            return "GET"
        case .updateCandidate, .updateFavoriteStatus:
            return "PUT"
        case .deleteCandidate:
            return "DELETE"
        }
    }

    var httpBody: Data? {
        switch self {
        case .auth(let email, let password):
            return try? JSONSerialization.data(withJSONObject: ["email": email, "password": password])
        case .register(let email, let password, let firstName, let lastName):
            return try? JSONSerialization.data(withJSONObject: ["email": email, "password": password, "firstName": firstName, "lastName": lastName])
        case .createCandidate(let email, let firstName, let lastName, let phone, let note, let linkedinURL),
             .updateCandidate(_, let email, let firstName, let lastName, let phone, let note, let linkedinURL):
            let body: [String: Any?] = ["email": email, "firstName": firstName, "lastName": lastName, "phone": phone, "note": note, "linkedinURL": linkedinURL]
            return try? JSONSerialization.data(withJSONObject: body.compactMapValues { $0 })
        case .getCandidates, .getCandidateDetail, .deleteCandidate, .updateFavoriteStatus:
            return nil
        }
    }
}








//var headers: [String: String]? {
//    switch self {
//    case .getCandidates(let token), .getCandidateDetail(_, let token), .createCandidate(let token, _, _, _, _, _, _), .updateCandidate(_, let token, _, _, _, _, _, _), .deleteCandidate(_, let token), .updateFavoriteStatus(_, let token):
//        return ["Authorization": "Bearer \(token)", "Content-Type": "application/json"]
//    case .auth, .register:
//        return ["Content-Type": "application/json"]
//    }
//}
