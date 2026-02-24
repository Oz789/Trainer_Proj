import Foundation

// MARK: - Payload (what the client fills out)

struct TrainerRequestPayload: Codable, Hashable {
    var goal: TrainingGoal
    var daysPerWeek: Int
    var equipment: EquipmentAccess
    var injuriesOrLimitations: String
    var notes: String

    init(
        goal: TrainingGoal = .hypertrophy,
        daysPerWeek: Int = 3,
        equipment: EquipmentAccess = .gym,
        injuriesOrLimitations: String = "",
        notes: String = ""
    ) {
        self.goal = goal
        self.daysPerWeek = daysPerWeek
        self.equipment = equipment
        self.injuriesOrLimitations = injuriesOrLimitations
        self.notes = notes
    }

    var isValid: Bool {
        (1...7).contains(daysPerWeek)
    }
}

// MARK: - Enums

enum TrainingGoal: String, Codable, CaseIterable, Identifiable {
    case fatLoss = "fat_loss"
    case strength = "strength"
    case hypertrophy = "hypertrophy"
    case endurance = "endurance"
    case performance = "performance"
    case generalHealth = "general_health"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .fatLoss: return "Fat Loss"
        case .strength: return "Strength"
        case .hypertrophy: return "Hypertrophy"
        case .endurance: return "Endurance"
        case .performance: return "Performance"
        case .generalHealth: return "General Health"
        }
    }
}

enum EquipmentAccess: String, Codable, CaseIterable, Identifiable {
    case gym = "gym"
    case home = "home"
    case both = "both"
    case none = "none"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .gym: return "Gym"
        case .home: return "Home"
        case .both: return "Both"
        case .none: return "None / Bodyweight"
        }
    }
}

// MARK: - DB Insert Model (what you send to Supabase)

struct TrainerClientRequestInsert: Codable, Hashable {
    let trainer_id: UUID
    let client_id: UUID
    let payload: TrainerRequestPayload

    init(trainerId: UUID, clientId: UUID, payload: TrainerRequestPayload) {
        self.trainer_id = trainerId
        self.client_id = clientId
        self.payload = payload
    }
}
