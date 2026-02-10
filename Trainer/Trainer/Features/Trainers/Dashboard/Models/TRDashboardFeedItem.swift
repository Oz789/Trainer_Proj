import SwiftUI

struct TRDashboardFeedItem: Identifiable {
    let id = UUID()
    let systemImage: String
    let badge: String
    let value: String
    let title: String
    let subtitle: String
}

struct TRDashboardOverviewRow: Identifiable {
    let id = UUID()
    let systemImage: String
    let title: String
    let subtitle: String
}

struct TRDashboardPost: Identifiable {
    struct Highlight {
        let value: String
        let label: String
    }

    let id = UUID()
    let systemImage: String
    let title: String
    let timestamp: String
    let badge: String?
    let body: String
    let highlight: Highlight?
}

enum TRDashboardMockData {
    static let posts: [TRDashboardPost] = [
        .init(
            systemImage: "dollarsign.circle.fill",
            title: "Weekly earnings updated",
            timestamp: "Just now",
            badge: "This week",
            body: "You’re trending up. Two sessions were paid today and one invoice is still pending.",
            highlight: .init(value: "$1,240", label: "earned so far")
        ),
        .init(
            systemImage: "calendar.badge.clock",
            title: "Appointments look good",
            timestamp: "30 min ago",
            badge: "Today",
            body: "You have 3 sessions today. Next session starts at 4:30 PM.",
            highlight: nil
        ),
        .init(
            systemImage: "person.2.fill",
            title: "New client inquiry",
            timestamp: "2 hr ago",
            badge: "New",
            body: "A new lead asked about a 4-week strength plan. Respond to convert them.",
            highlight: nil
        )
    ]

    // keep your existing overviewRows here
    static let overviewRows: [TRDashboardOverviewRow] = [
        .init(systemImage: "person.2.fill", title: "Manage Clients", subtitle: "View, message, and update clients"),
        .init(systemImage: "dumbbell.fill", title: "Manage Training Programs", subtitle: "Build and assign programs"),
        .init(systemImage: "calendar", title: "Manage Appointments", subtitle: "Schedule and review sessions"),
        .init(systemImage: "clock.arrow.circlepath", title: "Workout History", subtitle: "Review logs and adherence"),
        .init(systemImage: "creditcard.fill", title: "Payments", subtitle: "Payouts, history, and invoices")
    ]
}

