import Foundation
import Supabase

final class TrainerConnectionService {
    private let client: SupabaseClient

    init(client: SupabaseClient) {
        self.client = client
    }

    func findTrainerExact(_ search: String) async throws -> TrainerPublic? {
        let trimmed = search.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }

        let rows: [TrainerPublic] = try await client
            .rpc("find_trainer_exact", params: ["search": trimmed])
            .execute()
            .value

        return rows.first
    }

    func requestTrainer(trainerId: UUID) async throws {
        let userId = try await client.auth.session.user.id

        struct InsertRow: Encodable {
            let trainer_id: UUID
            let client_id: UUID
            let status: String
        }

        _ = try await client
            .from("Trainer_Cient_Connections")
            .insert(InsertRow(trainer_id: trainerId, client_id: userId, status: "pending"))
            .execute()
    }
}
