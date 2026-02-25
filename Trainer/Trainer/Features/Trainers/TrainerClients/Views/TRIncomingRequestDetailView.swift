import SwiftUI

struct TRIncomingRequestDetailView: View {
    let request: TRIncomingRequestRow

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("@\(request.clientUsername)")
                    .font(.title3.weight(.semibold))

                Text("Status: \(request.status)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                Divider().opacity(0.25)

                payloadRow("Age", value: request.payload.age.map(String.init) ?? "—")
                payloadRow("Sex", value: request.payload.sex.rawValue)
                payloadRow("Timeframe", value: request.payload.timeframe)
                payloadRow("Goal", value: request.payload.goalPreset.rawValue)
                payloadRow("Experience", value: request.payload.experience.rawValue)
                payloadRow("Equipment", value: request.payload.equipment.rawValue)
                payloadRow("Availability", value: "\(request.payload.availabilityDaysPerWeek) days/week")

                Divider().opacity(0.25)

                payloadRow("Injuries", value: request.payload.injuries)
                payloadRow("Conditions", value: request.payload.conditions)

                if !request.payload.notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Divider().opacity(0.25)
                    Text("Notes")
                        .font(.headline.weight(.semibold))
                    Text(request.payload.notes)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(16)
        }
        .navigationTitle("Request")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func payloadRow(_ title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.callout.weight(.semibold))
            Spacer()
            Text(value)
                .font(.callout)
                .foregroundStyle(.secondary)
        }
    }
}
