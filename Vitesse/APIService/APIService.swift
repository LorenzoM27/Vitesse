class APIService: ObservableObject {
    
    private let baseURL: String
    private let tokenManager: TokenManager
    private let session: URLSession
    
    init(baseURL: String = "http://127.0.0.1:8080", tokenManager: TokenManager = .shared, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.tokenManager = tokenManager
        self.session = session
    }
    
    private func createRequest(for endpoint: APIEndpoint) throws -> URLRequest {
        guard let url = URL(string: "\(baseURL)/\(endpoint.path)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token = tokenManager.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        request.httpBody = endpoint.httpBody

        return request
    }
    
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        let request = try createRequest(for: endpoint)
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw error
        }
    }
    
    func requestWithoutReturn(endpoint: APIEndpoint) async throws {
        let request = try createRequest(for: endpoint)
        let (_, response) = try await session.data(for: request)

        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
        }
    }
}