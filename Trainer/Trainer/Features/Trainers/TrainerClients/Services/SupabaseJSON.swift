import Foundation

enum SupabaseJSON {
    static func decoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        let isoFrac = ISO8601DateFormatter()
        isoFrac.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        let isoNoFrac = ISO8601DateFormatter()
        isoNoFrac.formatOptions = [.withInternetDateTime]
        
        let pgFrac = DateFormatter()
        pgFrac.locale = Locale(identifier: "en_US_POSIX")
        pgFrac.timeZone = TimeZone(secondsFromGMT: 0)
        pgFrac.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSXX"
        
        let pgNoFrac = DateFormatter()
        pgNoFrac.locale = Locale(identifier: "en_US_POSIX")
        pgNoFrac.timeZone = TimeZone(secondsFromGMT: 0)
        pgNoFrac.dateFormat = "yyyy-MM-dd HH:mm:ssXX"
        
        decoder.dateDecodingStrategy = .custom { decoder in
            let c = try decoder.singleValueContainer()
            let s = try c.decode(String.self)
            
            if let dt = isoFrac.date(from: s) { return dt }
            if let dt = isoNoFrac.date(from: s) { return dt }
            if let dt = pgFrac.date(from: s) { return dt }
            if let dt = pgNoFrac.date(from: s) { return dt }
            
            throw DecodingError.dataCorruptedError(in: c, debugDescription: "Invalid date: \(s)")
        }
        
        return decoder
        
    }
}
