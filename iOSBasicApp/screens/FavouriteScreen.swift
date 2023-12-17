import SwiftUI

struct FavouriteScreen: View {
    
    @EnvironmentObject private var viewModel: HPViewModel
        
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.likedCharacters, id: \.id) { character in
                        ZStack {
                            NavigationLink(destination: CharacterDetailScreen(character: character, viewModel: viewModel)) {}.frame(width: 0)
                            VStack {
                                AsyncImage(url: URL(string: character.image!)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    
                                }.frame(alignment: .center)
                                ZStack {
                                    Text(character.name ?? "").frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                        }
                    }.frame(maxWidth: .infinity) 
                }
            }.toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Favourites")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                }
            }
        }
    }
}
