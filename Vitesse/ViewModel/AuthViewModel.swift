class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false

    func loginSuccessful() {
        isAuthenticated = true
    }

    func logout() {
        isAuthenticated = false
    }
}