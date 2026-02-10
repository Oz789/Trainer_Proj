import SwiftUI

struct TRMainAppointmentsView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    private var t: ThemeTokens { themeManager.tokens(for: scheme) }

    enum Segment: String, CaseIterable, Identifiable {
        case upcoming = "Upcoming"
        case requests = "Requests"
        case past = "Past"
        var id: String { rawValue }
    }

    @State private var segment: Segment = .upcoming
    @State private var showNewAppointmentSheet = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: t.backgroundGradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 14) {
                TRAppointmentsHeader(
                    title: "Appointments",
                    subtitle: "Manage sessions, requests, and history",
                    onTapNew: { showNewAppointmentSheet = true }
                )

                TRAppointmentsSegmentedControl(
                    selection: $segment,
                    segments: Segment.allCases
                )

                Group {
                    switch segment {
                    case .upcoming:
                        TREmptyStateCard(
                            title: "No upcoming appointments",
                            subtitle: "When you schedule sessions with clients, they’ll show up here."
                        )
                    case .requests:
                        TREmptyStateCard(
                            title: "No requests right now",
                            subtitle: "New session requests and reschedules will appear here."
                        )
                    case .past:
                        TREmptyStateCard(
                            title: "No appointment history yet",
                            subtitle: "Completed and canceled sessions will be listed here."
                        )
                    }
                }
                .padding(.top, 4)

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
        }
        .sheet(isPresented: $showNewAppointmentSheet) {
            TRNewAppointmentSheet()
                .presentationDetents([.medium])
        }
    }
}

// MARK: - Preview

struct TRMainAppointmentsView_Previews: PreviewProvider {
    static var previews: some View {
        TRMainAppointmentsView()
            .environmentObject(ThemeManager())
            .preferredColorScheme(.dark)
    }
}
