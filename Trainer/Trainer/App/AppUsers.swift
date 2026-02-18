import Foundation

//MARK: This model is for the user roles of the app
enum AppUserRoles: String, Codable {
    case trainer
    case client
}

//MARK: This model is what makes up each user
struct AppUser: Identifiable, Equatable {
    let id: String
    let role: AppUserRoles
    let firstName: String
    let lastName: String
    let handle: String?

    //MARK: These two variables in the model are this way because we dont enforce it in the sign up. once that is done we can simplify it
    ///We dont even take a display name so we are combining the names for now to display something
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
