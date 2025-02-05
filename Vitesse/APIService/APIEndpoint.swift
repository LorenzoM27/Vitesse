enum APIEndpoint {
    case auth(email: String, password: String)
    case register(email: String, password: String, firstName: String, lastName: String)
    case getCandidates(token: String)
    case getCandidateDetail(candidateId: String, token: String)
    case createCandidate(token: String, email: String, firstName: String, lastName: String, phone: String?, note: String?, linkedinURL: String?)
    case updateCandidate(candidateId: String, token: String, email: String, firstName: String, lastName: String, phone: String?, note: String?, linkedinURL: String?)
    case deleteCandidate(candidateId: String, token: String)
    case updateFavoriteStatus(candidateId: String, token: String)
    
    var path: String {
        switch self {
        case .auth:
            return "/user/auth"
        case .register:
            return "/user/register"
        case .getCandidates:
            return "/candidate"
        case .getCandidateDetail(let candidateId, _):
            return "/candidate/\(candidateId)"
        case .createCandidate:
            return "/candidate"
        case .updateCandidate(let candidateId, _, _, _, _, _, _, _):
            return "/candidate/\(candidateId)"
        case .deleteCandidate(let candidateId, _):
            return "/candidate/\(candidateId)"
        case .updateFavoriteStatus(let candidateId, _):
            return "/candidate/\(candidateId)/favorite"
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
    
    var headers: [String: String]? {
        switch self {
        case .getCandidates(let token), .getCandidateDetail(_, let token), .createCandidate(let token, _, _, _, _, _, _), .updateCandidate(_, let token, _, _, _, _, _, _), .deleteCandidate(_, let token), .updateFavoriteStatus(_, let token):
            return ["Authorization": "Bearer \(token)", "Content-Type": "application/json"]
        case .auth, .register:
            return ["Content-Type": "application/json"]
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .auth(let email, let password):
            let body = ["email": email, "password": password]
            return try? JSONSerialization.data(withJSONObject: body)
        case .register(let email, let password, let firstName, let lastName):
            let body = ["email": email, "password": password, "firstName": firstName, "lastName": lastName]
            return try? JSONSerialization.data(withJSONObject: body)
        case .createCandidate(_, let email, let firstName, let lastName, let phone, let note, let linkedinURL),
             .updateCandidate(_, _, let email, let firstName, let lastName, let phone, let note, let linkedinURL):
            let body: [String: Any?] = ["email": email, "firstName": firstName, "lastName": lastName, "phone": phone, "note": note, "linkedinURL": linkedinURL]
            return try? JSONSerialization.data(withJSONObject: body.compactMapValues { $0 })
        case .getCandidates, .getCandidateDetail, .deleteCandidate, .updateFavoriteStatus:
            return nil
        }
    }
}
