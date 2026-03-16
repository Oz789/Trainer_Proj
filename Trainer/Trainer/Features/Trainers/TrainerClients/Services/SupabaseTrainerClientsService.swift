import Foundation
import Supabase

final class SupabaseTrainerClientsService: TrainerClientsServiceProtocol {
    private let client: SupabaseClient

    init(client: SupabaseClient) {
        self.client = client
    }

    func fetchIncomingRequests(trainerId: UUID) async throws -> [TRIncomingRequestRow] {
        print("fetchIncomingRequests trainerId =", trainerId.uuidString)

        let res = try await client
            .from(DBViews.incomingRequests)
            .select()
            .eq("trainer_id", value: trainerId.uuidString)
            .order("created_at", ascending: false)
            .execute()

        let raw = String(data: res.data, encoding: .utf8) ?? "<non-utf8>"
        print("incomingRequests raw:", raw)

        let rows = try SupabaseJSON.decoder().decode([TRIncomingRequestRow].self, from: res.data)
        print("incomingRequests decoded count =", rows.count)
        return rows
    }


    func fetchConnectedClients(trainerId: UUID, offset: Int, limit: Int) async throws -> [TRConnectedClient] {
        let from = offset
        let to = max(offset + limit - 1, offset)

        let res = try await client
            .from("trainer_connected_clients_view")
            .select()
            .eq("trainer_id", value: trainerId.uuidString)
            .order("started_at", ascending: false)
            .range(from: from, to: to)
            .execute()

        do {
            return try SupabaseJSON.decoder().decode([TRConnectedClient].self, from: res.data)
        } catch {
            let raw = String(data: res.data, encoding: .utf8) ?? "<non-utf8>"
            print("fetchConnectedClients decode failed:", error)
            print("raw response:\n\(raw)")
            throw error
        }
    }

    
    func acceptRequest(requestId: UUID) async throws {
        _ = try await client
            .rpc("accept_trainer_request", params: [
                "p_request_id": requestId.uuidString
            ])
            .execute()
    }

    func declineRequest(requestId: UUID, reason: String) async throws {
        _ = try await client
            .rpc("decline_trainer_request", params: [
                "p_request_id": requestId.uuidString,
                "p_reason": reason
            ])
            .execute()
    }



}
