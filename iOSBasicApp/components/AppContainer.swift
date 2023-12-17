import SwiftUI

struct AppContainer: View {
    
    private var viewModel: HPViewModel = HPViewModel(service: HPNetworkClient())
    
    var body: some View {
        TabView {
            CharacterListScreen()
                .tabItem {
                    Label("Characters", systemImage: "person")
                }
                .environmentObject(viewModel)
            SpellScreen()
                .tabItem {
                    Label("Spells", image: "wand_icon")
                }
                .environmentObject(viewModel)
            FavouriteScreen()
                .tabItem {
                    Label("Favourites", systemImage: "heart")
                }
                .environmentObject(viewModel)
        }
    }
}


struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        AppContainer()
    }
}
