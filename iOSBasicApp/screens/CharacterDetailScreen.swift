import SwiftUI

struct CharacterDetailScreen: View {
    
    var viewModel: HPViewModel
    
    var character: Character
    
    init(character: Character, viewModel: HPViewModel) {
        self.character = character
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.image!)) { image in
                image
                    .resizable()
                    .padding(16)
                    .frame(width: UIScreen.main.bounds.size.width, height: 500)
                    .scaledToFit()
            } placeholder: {
                
            }
            ZStack(alignment: .top) {
                if (character.favourite ?? false) {
                    Button {
                        viewModel.likeCharacter(characterId: character.id)
                    } label: {
                        Image(systemName: "heart.fill")
                            .padding(EdgeInsets(.init(top: 10, leading: 0, bottom: 0, trailing: 20)))
                            .foregroundColor(.red)
                    }.frame(maxWidth: .infinity, alignment: .topTrailing)
                } else {
                    Button {
                        viewModel.likeCharacter(characterId: character.id)
                    } label: {
                        Image(systemName: "heart")
                            .padding(EdgeInsets(.init(top: 10, leading: 0, bottom: 0, trailing: 20)))
                            .foregroundColor(.red)
                    }.frame(maxWidth: .infinity, alignment: .topTrailing)
                }
                VStack {
                    Text(character.name!).font(.title2)
                    HStack {
                        Text("Ancestry: " + String(character.ancestry ?? "")).font(.body)
                    }
                    HStack {
                        Text("Species: " + String(character.species ?? "")).font(.body)
                    }
                    HStack {
                        Text("Date of birth: " + String(character.dateOfBirth ?? "")).font(.body)
                    }
                }
            }
        }.frame(maxWidth: .infinity)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Character")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                }
            }
    }
}

