import Foundation
import Supabase

enum TrainerRequestServiceError: LocalizedError {
    case notAuthenticated
    case requestAlreadyPending
    case unknown

    var errorDescription: String? {
        switch self {
        case .notAuthenticated: return "You must be logged in to send a request."
        case .requestAlreadyPending: return "You already have a pending request with this trainer."
        case .unknown: return "Request failed. Please try again."
        }
    }
}

final class SupabaseTrainerRequestService: TrainerRequestServiceProtocol {
    private let client: SupabaseClient
    private let currentUserId: () -> UUID?

    init(client: SupabaseClient, currentUserId: @escaping () -> UUID?) {
        self.client = client
        self.currentUserId = currentUserId
    }

    func submitRequest(trainerId: UUID, payload: TrainerRequestPayload) async throws {
        guard let uid = currentUserId() else {
            throw TrainerRequestServiceError.notAuthenticated
        }

        struct InsertRow: Encodable {
            let trainer_id: UUID
            let client_id: UUID
            let status: String
            let payload: TrainerRequestPayload
        }

        let row = InsertRow(
            trainer_id: trainerId,
            client_id: uid,
            status: "pending",
            payload: payload
        )

        do {
            _ = try await client
                .from("trainer_client_requests")
                .insert(row)
                .execute()
        } catch {
            let msg = String(describing: error).lowercased()
            if msg.contains("23505") || msg.contains("uq_one_pending_request_per_pair") || msg.contains("duplicate") {
                throw TrainerRequestServiceError.requestAlreadyPending
            }

            throw TrainerRequestServiceError.unknown
        }
    }
}
