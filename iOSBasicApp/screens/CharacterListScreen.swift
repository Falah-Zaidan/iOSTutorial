import SwiftUI
import URLImage

struct CharacterListScreen: View {
    
    @EnvironmentObject private var viewModel: HPViewModel
    
    @State private var searchText = ""
    @State private var searchIsActive = false
    @State private var viewAppeared = false
    
    var body: some View {
        NavigationView {
            VStack {
                switch (viewModel.resultState) {
                case .successfulResponse:
                    NavigationStack {
                        List {
                            ForEach(viewModel.filteredCharacterList, id: \.id) { character in
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
                                            if (character.favourite ?? false) {
                                                Image(systemName: "heart.fill")
                                                    .padding(EdgeInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 20)))
                                                    .foregroundColor(.red)
                                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                            }
                                        }
                                    }
                                }
                            }.frame(maxWidth: .infinity)
                        }.toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("Characters")
                                    .font(.largeTitle.bold())
                                    .accessibilityAddTraits(.isHeader)
                            }
                        }
                    }
                    .searchable(text: $searchText)
                    .onSubmit(of: .search) {
                        viewModel.filterCharacters(searchText: searchText)
                    }
                    .onChange(of: searchText, perform: { text in
                        if text.isEmpty {
                            viewModel.resetCharacters()
                        }
                    })
                case .loading:
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                case .failed:
                    Button {
                        viewModel.getCharacters()
                    } label: {
                        Text("Retry")
                    }
                }
            }
        }.onAppear{
            if (!viewAppeared) {
                viewModel.getCharacters()
                viewAppeared = true
            }
        }
    }
}
