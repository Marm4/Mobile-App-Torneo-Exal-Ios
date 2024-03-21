import Foundation


class Usuario {
    private var id: String
    private var email: String
    private var admin: Bool

    init(id: String, email: String, admin: Bool) {
        self.id = id
        self.email = email
        self.admin = admin
    }
    

    convenience init() {
        self.init(id: "", email: "", admin: false)
    }

    func getId() -> String {
        return id
    }

    func setId(id: String) {
        self.id = id
    }

    func getEmail() -> String {
        return email
    }

    func setEmail(email: String) {
        self.email = email
    }

    func isAdmin() -> Bool {
        return admin
    }

    func setAdmin(admin: Bool) {
        self.admin = admin
    }
}
