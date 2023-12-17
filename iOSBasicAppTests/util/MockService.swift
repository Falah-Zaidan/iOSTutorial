import Foundation

class MockService : HPService {
    let mockCharacterData: [Character]?
    let mockSpellData: [Spell]?
    
    init(mockCharacterData: [Character]?, mockSpellData: [Spell]?) {
        self.mockCharacterData = mockCharacterData
        self.mockSpellData = mockSpellData
    }
    
    func getCharacters(completion: @escaping ([Character]?, Error?) -> Void) {
        completion(mockCharacterData, nil)
    }
    
    func getSpells(completion: @escaping ([Spell]?, Error?) -> Void) {
        completion(mockSpellData, nil)
    }
}
