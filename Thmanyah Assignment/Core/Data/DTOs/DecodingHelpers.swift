//
//  DecodingHelpers.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 09/03/2026.
//

extension KeyedDecodingContainer {
    /// Decodes an Int from either a JSON Int or a JSON String.
    /// Returns 0 if the value is a non-numeric string.
    func decodeIntOrString(forKey key: Key) throws -> Int {
        if let intValue = try? decode(Int.self, forKey: key) {
            return intValue
        }
        let stringValue = try decode(String.self, forKey: key)
        return Int(stringValue) ?? 0
    }
}
