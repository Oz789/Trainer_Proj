import Foundation

@MainActor
final class TRMainClientsViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published private(set) var pending: [TRIncomingRequestRow] = []
    @Published private(set) var connected: [TRConnectedClient] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isLoadingMore: Bool = false
    @Published var errorMessage: String? = nil

    private let service: TrainerClientsServiceProtocol
    private(set) var connectedOffset: Int = 0
    private let pageSize: Int = 10
    private(set) var reachedEnd: Bool = false

    init(service: TrainerClientsServiceProtocol) {
        self.service = service
    }

    func load(trainerId: UUID) async {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }

        async let reqsTask = service.fetchIncomingRequests(trainerId: trainerId)
        async let connTask = service.fetchConnectedClients(trainerId: trainerId, offset: 0, limit: pageSize)

        do {
            let incoming = try await reqsTask
            pending = incoming
        } catch {
            pending = []
            if errorMessage == nil {
                errorMessage = "Failed to load requests: \(error.localizedDescription)"
            }
            print("fetchIncomingRequests failed:", error)
        }

        do {
            let connectedFirst = try await connTask
            connected = connectedFirst
            connectedOffset = connectedFirst.count
            reachedEnd = connectedFirst.count < pageSize
        } catch {
            connected = []
            connectedOffset = 0
            reachedEnd = true
            if errorMessage == nil {
                errorMessage = "Failed to load connected clients: \(error.localizedDescription)"
            }
            print("fetchConnectedClients failed:", error)
        }
    }


    func loadMoreConnected(trainerId: UUID) async {
        guard !reachedEnd, !isLoadingMore else { return }

        isLoadingMore = true
        defer { isLoadingMore = false }

        do {
            let next = try await service.fetchConnectedClients(
                trainerId: trainerId,
                offset: connectedOffset,
                limit: pageSize
            )

            connected.append(contentsOf: next)
            connectedOffset += next.count
            if next.count < pageSize { reachedEnd = true }
        } catch {
            errorMessage = "Failed to load more."
        }
    }

    // MARK: - (client-side search)

    var pendingFiltered: [TRIncomingRequestRow] {
        let q = searchText.trimLower
        guard !q.isEmpty else { return pending }
        return pending.filter { $0.clientUsername.lowercased().contains(q) }
    }

    var connectedFiltered: [TRConnectedClient] {
        let q = searchText.trimLower
        guard !q.isEmpty else { return connected }
        return connected.filter { $0.clientUsername.lowercased().contains(q) }
    }

    var canShowMoreConnected: Bool {
        !reachedEnd && !connectedFiltered.isEmpty
    }
}

private extension String {
    var trimLower: String {
        trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
}
