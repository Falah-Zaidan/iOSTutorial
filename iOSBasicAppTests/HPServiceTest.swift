import XCTest
@testable import iOSBasicApp

class HPServiceTest: XCTestCase {
    
    var apiClient: MockService!
    var mockCharacterData: [Character]?
    var mockSpellData: [Spell]?
    
    override func setUp() {
        super.setUp()

        if let path = Bundle.main.path(forResource: "characterData", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                mockCharacterData = try JSONDecoder().decode([Character].self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        if let path = Bundle.main.path(forResource: "spellData", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                mockSpellData = try JSONDecoder().decode([Spell].self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        let mockService = MockService(mockCharacterData: mockCharacterData, mockSpellData: mockSpellData)
        apiClient = mockService
    }
    
    override func tearDown() {
        apiClient = nil
        super.tearDown()
    }
    
    func testGetCharacters() {
        let expectation = self.expectation(description: "Fetch all Characters")
        
        apiClient.getCharacters(completion: { result, error in
            
            XCTAssert(result! == self.mockCharacterData)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetSpells() {
        let expectation = self.expectation(description: "Fetch all Spells")
        
        apiClient.getSpells(completion: { result, error in
            
            XCTAssert(result! == self.mockSpellData)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
    }
    
}
