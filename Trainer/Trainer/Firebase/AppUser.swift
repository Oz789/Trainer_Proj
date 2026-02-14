import Foundation

struct AppUser: Identifiable, Equatable {
    let id: String
    let role: AppUserRoles
    let firstName: String
    let lastName: String
    let handle: String?

    var displayName: String {
        let full = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespacesAndNewlines)
        return full.isEmpty ? "Trainer" : full
    }

    var displayHandle: String {
        if let h = handle?.trimmingCharacters(in: .whitespacesAndNewlines), !h.isEmpty {
            return h.hasPrefix("@") ? h : "@\(h)"
        }
        let base = (firstName + lastName)
            .lowercased()
            .replacingOccurrences(of: " ", with: "")
        return base.isEmpty ? "@trainer" : "@\(base)"
    }
}
