//Swift 'struct'
struct Character: Codable, Equatable {
    var id: String
    var name: String?
    var alternate_names: [String]?
    var species: String?
    var gender: String?
    var house: String?
    var dateOfBirth: String?
    var yearOfBirth: Int64?
    var wizard: Bool?
    var ancestry: String?
    var eyeColour: String?
    var hairColour: String?
    var wand: Wand?
    var patronus: String?
    var hogwartsStudent: Bool?
    var hogwartsStaff: Bool?
    var actor: String?
    var alternate_actors: [String]?
    var alive: Bool?
    var image: String?
    
    var favourite: Bool? = false
    
    struct Wand: Codable, Equatable {
        var wood: String?
        var core: String?
        var length: Double?
    }
}
