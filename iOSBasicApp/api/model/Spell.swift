import Foundation

public struct SpellResponse: Codable {
    let results: [Spell]
}

struct Spell: Codable, Equatable {
    let id: String
    let name: String
    let description: String
}
