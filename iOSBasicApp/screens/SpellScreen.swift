import SwiftUI

struct SpellScreen: View {
    
    @EnvironmentObject private var viewModel: HPViewModel
    @State private var viewAppeared = false
    
    var body: some View {
        VStack {
            switch (viewModel.resultState) {
                case .loading:
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                case .failed:
                    Button {
                        viewModel.getSpells()
                    } label: {
                        Text("Retry")
                    }
                case .successfulResponse:
                    NavigationView {
                        List {
                            ForEach(viewModel.spells, id: \.id) { spell in
                                VStack {
                                    Text(spell.name)
                                        .font(.title)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    Spacer().frame(height: 3)
                                    Text(spell.description)
                                        .font(.body)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    Divider()
                                }.listRowSeparator(.hidden)
                            }
                        }.toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("Spells")
                                    .font(.largeTitle.bold())
                                    .accessibilityAddTraits(.isHeader)
                            }
                        }
                    }
            }
        }.onAppear {
            if (!viewAppeared) {
                viewModel.getSpells()
                viewAppeared = true
            }
        }
    }
}
