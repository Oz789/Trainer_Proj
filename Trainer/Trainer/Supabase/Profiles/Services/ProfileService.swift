import Foundation
import Supabase

struct ProfileService {

    func fetchMyProfile() async throws -> Profile {
        let session = try await supabase.auth.session
        let user = session.user

        return try await supabase
            .from("profiles")
            .select()
            .eq("id", value: user.id.uuidString)
            .single()
            .execute()
            .value
    }

    func updateUsername(_ username: String) async throws {
        let session = try await supabase.auth.session
        let user = session.user

        try await supabase
            .from("profiles")
            .update(["username": username])
            .eq("id", value: user.id.uuidString)
            .execute()
    }
}
