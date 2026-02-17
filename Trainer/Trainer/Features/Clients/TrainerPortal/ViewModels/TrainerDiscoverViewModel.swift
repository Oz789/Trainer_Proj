import Foundation
import Supabase

@MainActor
final class TrainerDiscoverViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var isSearching: Bool = false
    @Published var result: TrainerPublic? = nil
    @Published var errorMessage: String? = nil
    @Published var isRequesting: Bool = false

    private let service: TrainerConnectionService

    init(service: TrainerConnectionService) {
        self.service = service
    }

    func searchExact() async {
        errorMessage = nil
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else {
            result = nil
            return
        }

        isSearching = true
        defer { isSearching = false }

        do {
            result = try await service.findTrainerExact(q)
        } catch {
            result = nil
            errorMessage = "Search failed."
        }
    }

    func requestTrainer() async {
        guard let trainer = result else { return }
        errorMessage = nil

        isRequesting = true
        defer { isRequesting = false }

        do {
            try await service.requestTrainer(trainerId: trainer.id)
        } catch {
            errorMessage = "Request failed."
        }
    }
}
