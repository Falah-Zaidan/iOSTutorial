import Foundation
import Combine

enum ResultState {
    case loading
    case failed
    case successfulResponse
}

public class HPViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    let service: HPService
    
    init(service: HPService) {
        self.service = service
    }
    
    @Published private(set) var characterList = [Character]()
    @Published private(set) var filteredCharacterList = [Character]()
    @Published private(set) var resultState: ResultState = .loading
    @Published private(set) var likedCharacters = [Character]()
    private(set) var spells = [Spell]()
    
    func getCharacters() {
            
        self.resultState = .loading
        
        self.service.getCharacters { characters, error in
            if (error == nil) {
                self.resultState = .successfulResponse
                guard let characters = characters else {
                    return
                }
                self.characterList = characters
                self.filteredCharacterList = characters
            } else {
                self.resultState = .failed
            }
        }
    }
    
    func getSpells() {
        
        self.resultState = .loading
        
        self.service.getSpells { spells, error in
            if (error == nil) {
                self.resultState = .successfulResponse
                guard let spells = spells else {
                    return
                }
                self.spells = spells
            } else {
                self.resultState = .failed
            }
        }
    }
    
    func likeCharacter(characterId: String) {
        
        var character = Character(id: characterId)
        
        for char in self.characterList {
            if (char.id == characterId) {
                
                character = Character(
                    id: char.id,
                    name: char.name,
                    alternate_names: char.alternate_names,
                    species: char.species,
                    gender: char.gender,
                    house: char.house,
                    dateOfBirth: char.dateOfBirth,
                    yearOfBirth: char.yearOfBirth,
                    wizard: char.wizard,
                    ancestry: char.ancestry,
                    eyeColour: char.eyeColour,
                    hairColour: char.hairColour,
                    wand: char.wand,
                    patronus: char.patronus,
                    hogwartsStudent: char.hogwartsStudent,
                    hogwartsStaff: char.hogwartsStaff,
                    actor: char.actor,
                    alternate_actors: char.alternate_actors,
                    alive: char.alive,
                    image: char.image,
                    favourite: !(char.favourite ?? false)
                )
            }
        }
        
        var newCharacterList = [Character]()
        
        self.characterList.forEach {
            if($0.id == characterId) {
                newCharacterList.append(character)
            } else {
                newCharacterList.append($0)
            }
        }
        
        self.characterList = newCharacterList
        self.filteredCharacterList = newCharacterList
        self.likedCharacters = newCharacterList.filter{ $0.favourite == true }
        
    }
    
    func filterCharacters(searchText: String) {
        self.characterList.forEach {
            if (($0.name?.lowercased().contains(searchText)) != nil) {
                self.filteredCharacterList = self.characterList.filter{$0.name?.lowercased() == searchText.lowercased()}
            }
        }
    }
    
    func resetCharacters() {
        self.filteredCharacterList = characterList
    }
}
