import Foundation
import Supabase

enum TrainerRequestServiceError: LocalizedError {
    case notAuthenticated
    case requestAlreadyPending
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .notAuthenticated:
            return "You must be logged in to send a request."
        case .requestAlreadyPending:
            return "You already have a pending request with this trainer."
        case .unknown(let msg):
            return msg
        }
    }
}

protocol TrainerRequestServiceProtocol {
    func submitRequest(trainerId: UUID, payload: TrainerRequestPayload) async throws
}

/// Writes into: public.trainer_client_requests
final class TrainerRequestService: TrainerRequestServiceProtocol {
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

        // Insert model matching your table column names
        struct InsertRow: Encodable {
            let trainer_id: UUID
            let client_id: UUID
            let payload: TrainerRequestPayload
            let status: String  // "pending"
        }

        let row = InsertRow(
            trainer_id: trainerId,
            client_id: uid,
            payload: payload,
            status: "pending"
        )

        do {
            _ = try await client
                .from("trainer_client_requests")
                .insert(row)
                .execute()
        } catch {
            // Duplicate pending request will trigger unique index violation (Postgres 23505)
            // Supabase Swift errors vary by version; safest is string match on 23505.
            let msg = String(describing: error)

            if msg.contains("23505") || msg.lowercased().contains("duplicate") || msg.lowercased().contains("uq_one_pending_request_per_pair") {
                throw TrainerRequestServiceError.requestAlreadyPending
            }

            throw TrainerRequestServiceError.unknown("Request failed. Please try again.")
        }
    }
}
