import Foundation
import Supabase

enum SupabaseConfig {
    static let url = URL(string: "https://izelozkxapaevkzxxbax.supabase.co")! 
    static let anonKey = "sb_publishable_OYDAB3OH6NZJ6q-nXhpnPg_JkVFZHug"
}
let supabase = SupabaseClient(
    supabaseURL: SupabaseConfig.url,
    supabaseKey: SupabaseConfig.anonKey
)
