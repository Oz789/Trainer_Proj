import SwiftUI

enum AppRoleTabs: Hashable {
    case home
    case discover
    case profile

    // Trainer-specific
    case clients
    case programs
    case dashboard

    // Client-specific
    case workouts

    var title: String {
        switch self {
        case .home: return "Home"
        case .discover: return "Discover"
        case .profile: return "Profile"
        case .clients: return "Clients"
        case .programs: return "Builder"
        case .dashboard: return "Dashboard"
        case .workouts: return "Workouts"
        }
    }

    var systemImage: String {
        switch self {
        case .home: return "house.fill"
        case .discover: return "sparkles"
        case .profile: return "person.fill"
        case .clients: return "person.2.fill"
        case .programs: return "dumbbell.fill"
        case .dashboard: return "lines.3.horizontal"
        case .workouts: return "dumbbell.fill"
        }
    }
}

struct TabConfig {
    let role: AppUserRoles

    var tabs: [AppRoleTabs] {
        switch role {
        case .trainer:
            return [.profile, .dashboard,.clients, .programs]
        case .client:
            return [.profile, .workouts, .dashboard]
        }
    }
}
