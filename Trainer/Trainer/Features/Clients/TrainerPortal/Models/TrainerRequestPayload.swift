import Foundation

struct TrainerRequestPayload: Codable, Hashable {
    var age: Int?
    var sex: Sex
    var heightFeet: Int?
    var heightInches: Int?
    var experience: Experience
    var goalPreset: GoalPreset
    var goalCustom: String?
    var timeframe: String
    var injuries: String
    var conditions: String
    var availabilityDaysPerWeek: Int
    var equipment: Equipment

    var notes: String

    init(
        age: Int? = nil,
        sex: Sex = .unspecified,
        heightFeet: Int? = nil,
        heightInches: Int? = nil,
        experience: Experience = .beginner,
        goalPreset: GoalPreset = .hypertrophy,
        goalCustom: String? = nil,
        timeframe: String = "",
        injuries: String = "",
        conditions: String = "",
        availabilityDaysPerWeek: Int = 3,
        equipment: Equipment = .gym,
        notes: String = ""
    ) {
        self.age = age
        self.sex = sex
        self.heightFeet = heightFeet
        self.heightInches = heightInches
        self.experience = experience
        self.goalPreset = goalPreset
        self.goalCustom = goalCustom
        self.timeframe = timeframe
        self.injuries = injuries
        self.conditions = conditions
        self.availabilityDaysPerWeek = availabilityDaysPerWeek
        self.equipment = equipment
        self.notes = notes
    }


    enum Sex: String, Codable, CaseIterable, Hashable {
        case male, female, unspecified
        var display: String {
            switch self {
            case .male: return "Male"
            case .female: return "Female"
            case .unspecified: return "Prefer not to say"
            }
        }
    }

    enum Experience: String, Codable, CaseIterable, Hashable {
        case new, beginner, intermediate, advanced

        var label: String {
            switch self {
            case .new: return "New"
            case .beginner: return "Beginner 0–1 Years"
            case .intermediate: return "Intermediate 2–5 Years"
            case .advanced: return "Advanced 5+ Years"
            }
        }
    }

    enum GoalPreset: String, Codable, CaseIterable, Hashable {
        case fatLoss
        case strength
        case hypertrophy
        case endurance
        case performance
        case generalHealth
        case custom

        var displayName: String {
            switch self {
            case .fatLoss: return "Fat Loss"
            case .strength: return "Strength"
            case .hypertrophy: return "Hypertrophy"
            case .endurance: return "Endurance"
            case .performance: return "Performance"
            case .generalHealth: return "General Health"
            case .custom: return "Custom…"
            }
        }
    }

    enum Equipment: String, Codable, CaseIterable, Hashable {
        case gym, home, both, none

        var displayName: String {
            switch self {
            case .gym: return "Gym"
            case .home: return "Home"
            case .both: return "Both"
            case .none: return "None / Bodyweight"
            }
        }
    }
    
    var canAdvanceFromBasics: Bool {
        !timeframe.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
