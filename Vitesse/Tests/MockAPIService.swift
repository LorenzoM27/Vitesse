import Foundation

class MockAPIService: APIService {
    private let shouldSucceed: Bool
    private let error: Error?
    private let response: Any?
    
    init(shouldSucceed: Bool = true, error: Error? = nil, response: Any? = nil) {
        self.shouldSucceed = shouldSucceed
        self.error = error
        self.response = response
    }
    
    override func requestWithoutReturn(endpoint: APIEndpoint) async throws {
        if !shouldSucceed {
            throw error ?? URLError(.badServerResponse)
        }
    }
    
    override func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        if let response = response as? T {
            return response
        } else if !shouldSucceed, let error = error {
            throw error
        }
        throw URLError(.badURL)
    }
}
