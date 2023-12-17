import XCTest
@testable import iOSBasicApp

final class HPViewModelTests: XCTestCase {
    
    var characterList: [Character]? = nil
    var spellList: [Spell]? = nil

    override func setUpWithError() throws {
        // Deserialize Character list JSON file into CharacterList
        if let path = Bundle.main.path(forResource: "characterData", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                characterList = try JSONDecoder().decode([Character].self, from: data)
                print("Deserialized Data: \(characterList?.count)")
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        // Deserialize Spell list JSON file into SpellList
        if let path = Bundle.main.path(forResource: "spellData", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                spellList = try JSONDecoder().decode([Spell].self, from: data)
                print("Deserialized Data: \(spellList?.count)")
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
    }
    
    func testGetCharacters() {
        
        let viewModel = HPViewModel(service: MockService(mockCharacterData: characterList, mockSpellData: spellList)) //init the VM
        
        viewModel.getCharacters() //call getCharacters()
        
        XCTAssertEqual(viewModel.characterList.count, characterList?.count) //Check that the characterList in the VM contains the same number of characters in the deserialized JSON file
        
    }
    
    func testGetSpells() {
        
        let viewModel = HPViewModel(service: MockService(mockCharacterData: characterList, mockSpellData: spellList))
        
        viewModel.getSpells()
        
        XCTAssertEqual(viewModel.spells.count, spellList?.count)
    }

}
