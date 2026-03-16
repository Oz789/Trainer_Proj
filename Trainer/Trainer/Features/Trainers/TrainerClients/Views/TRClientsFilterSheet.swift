import SwiftUI

struct TRClientsFilterState: Equatable {
    var sort: TRClientSortOption = .az
    var showOnlyActive: Bool = false
    var showUnreadMessages: Bool = false
    var showNewestFirst: Bool = false
}

enum TRClientSortOption: String, CaseIterable, Identifiable {
    case az = "A–Z"
    case za = "Z–A"

    var id: String { rawValue }
}

struct TRClientsFilterSheet: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    @Environment(\.dismiss) private var dismiss

    @Binding var filters: TRClientsFilterState

    private var t: ThemeTokens { themeManager.tokens(for: scheme) }
    private var titleColor: Color { scheme == .dark ? t.titleColor : .black }
    private var textSecondary: Color { scheme == .dark ? t.textSecondary : .black.opacity(0.55) }
    private var cardFill: Color { scheme == .dark ? t.cardBackground : .white }

    var body: some View {
        ZStack {
            LinearGradient(colors: t.backgroundGradient, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                header

                filterCard {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Sort")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(textSecondary)

                        Picker("Sort", selection: $filters.sort) {
                            ForEach(TRClientSortOption.allCases) { option in
                                Text(option.rawValue)
                                    .tag(option)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }

                filterCard {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Filters")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(textSecondary)

                        Toggle("Active clients only", isOn: $filters.showOnlyActive)
                            .tint(titleColor)
                            .disabled(true)

                        Toggle("Unread messages", isOn: $filters.showUnreadMessages)
                            .tint(titleColor)
                            .disabled(true)

                        Toggle("Newest first", isOn: $filters.showNewestFirst)
                            .tint(titleColor)
                            .disabled(true)

                        Text("More filters coming soon")
                            .font(.caption)
                            .foregroundStyle(textSecondary)
                    }
                }

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 18)
            .padding(.top, 12)
            .padding(.bottom, 20)
        }
    }

    private var header: some View {
        ZStack {
            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(titleColor)
                        .frame(width: 32, height: 32)
                        .background(cardFill.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .buttonStyle(.plain)

                Spacer()
            }

            Text("Filters")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(titleColor)
        }
    }

    private func filterCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(cardFill)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(scheme == .dark ? .white.opacity(0.08) : .black.opacity(0.08), lineWidth: 1)
            )
    }
}
