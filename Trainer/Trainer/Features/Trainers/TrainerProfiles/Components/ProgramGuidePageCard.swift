import SwiftUI

struct ProgramGuidePageCard: View {
    let number: String
    let title: String
    let details: String
    var body: some View {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
            .fill(.white)
            .overlay(
                VStack(alignment: .leading, spacing: 10) {
                    Text(number)
                        .font(.system(size: 42, weight: .bold))
                        .foregroundStyle(.black.opacity(0.16))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(title)
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.black.opacity(0.86))

                    Text(details)
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.55))
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer(minLength: 0)
                }
                .padding(18)
            )
            .shadow(color: .black.opacity(0.06), radius: 18, x: 0, y: 10)
            .padding(.vertical, 8)
            
    }
}

#Preview {
    ZStack {
        Color(.systemGroupedBackground).ignoresSafeArea()
        ProgramGuidePageCard(
            number: "Week 1",
            title: "Push Routine",
            details: "Add Routine Stuff Here"
        )
        .padding()
    }
}
