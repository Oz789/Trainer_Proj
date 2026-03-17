import SwiftUI

struct TRNewAppointmentSheet: View {
    var body: some View {
        VStack(spacing: 14) {
            Capsule()
                .fill(.white.opacity(0.25))
                .frame(width: 44, height: 5)
                .padding(.top, 8)

            Text("New Appointment")
                .font(.system(size: 18, weight: .semibold))
                .padding(.top, 6)

            Text("Next we’ll build: pick client, date/time, type, and notes.")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 18)

            Spacer()
        }
        .padding(.bottom, 10)
    }
}

struct TRNewAppointmentSheet_Previews: PreviewProvider {
    static var previews: some View {
        TRNewAppointmentSheet()
            .preferredColorScheme(.dark)
    }
}
