import SwiftUI
import Supabase

struct TrainerDiscoverView: View {
    @StateObject private var vm: TrainerDiscoverViewModel

    init(viewModel: TrainerDiscoverViewModel) {
        _vm = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header

            searchField

            if let err = vm.errorMessage {
                Text(err)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }

            if vm.query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text("Enter the trainer’s **exact** name or **exact** handle (example: **@OzTrainer**).")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)
            } else if vm.isSearching {
                Text("Searching…")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)
            } else if vm.result == nil {
                Text("No match.")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)
            } else {
                resultCard
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Find Your Trainer")
                .font(.title2.weight(.semibold))

            Text("Results appear only on an exact match.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }

    private var searchField: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Type exact name or @handle", text: $vm.query)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .submitLabel(.search)
                .onSubmit { Task { await vm.searchExact() } }

            if !vm.query.isEmpty {
                Button {
                    vm.query = ""
                    vm.result = nil
                    vm.errorMessage = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .strokeBorder(.white.opacity(0.10), lineWidth: 1)
        )
    }

    private var resultCard: some View {
        let t = vm.result!

        return VStack(alignment: .leading, spacing: 10) {
            Text("Result")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                Circle()
                    .fill(.thinMaterial)
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(.secondary)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text("@\(t.username)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button {
                    Task { await vm.requestTrainer() }
                } label: {
                    Text(vm.isRequesting ? "Requesting…" : "Request")
                        .font(.subheadline.weight(.semibold))
                }
                .buttonStyle(.borderedProminent)
                .disabled(vm.isRequesting)
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(.white.opacity(0.10), lineWidth: 1)
            )
        }
        .padding(.top, 6)
    }
}
