import SwiftUI

struct SettingsRow: View {
    let title: String
    var value: String? = nil

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if let value {
                Text(value)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
