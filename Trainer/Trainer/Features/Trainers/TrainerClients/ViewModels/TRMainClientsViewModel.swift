import Foundation
import Observation

@MainActor
@Observable
final class TRMainClientsViewModel {

    var searchText: String = ""
    var selectedFilter: TRClient.Status = .active

    // MARK: - Data
    private(set) var clients: [TRClient] = []

    var filteredClients: [TRClient] {
        let byStatus = clients.filter { client in
            selectedFilter == .all ? true : client.status == selectedFilter
        }

        guard !searchText.isEmpty else { return byStatus }

        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { return byStatus }

        return byStatus.filter { client in
            client.name.localizedCaseInsensitiveContains(q) ||
            client.handle.localizedCaseInsensitiveContains(q) ||
            client.subtitle.localizedCaseInsensitiveContains(q)
        }
    }

    var counts: Counts {
        Counts(
            active: clients.filter { $0.status == .active }.count,
            needsCheckIn: clients.filter { $0.status == .needsCheckIn }.count,
            new: clients.filter { $0.status == .new }.count,
            total: clients.count
        )
    }

    init(clients: [TRClient] = []) {
        self.clients = clients
    }

    func loadSample() {
        self.clients = TRClient.sample
    }

    struct Counts: Hashable {
        let active: Int
        let needsCheckIn: Int
        let new: Int
        let total: Int
    }
}
