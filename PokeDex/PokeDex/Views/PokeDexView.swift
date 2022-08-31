//
//  PokeDexView.swift
//  PokeDex
//
//  Created by Tushar Kalra on 01/06/21.
//

import SwiftUI

struct PokeDexView: View {
    
    //MARK: - Variables
    
    @Namespace var expandTransition
    @Namespace var rotateTransition
    
    @State var expand = false
    @State var selection : Pokemon?
    
    @State var showFilterButtons = false
    @State var filterApplied = false
    
    @State var animationAmount = 0.0
    @State var rotate = false
    
    @StateObject var viewModel = PokeDexViewModel()
    
    //MARK: - View
    var body: some View {
        
        return VStack {
            if !expand {
                NavigationView {
                    ZStack(alignment: .bottomTrailing) {
                        VStack(alignment: .leading) {
                            
                            HStack(alignment: .bottom) {
                                Text("PokeDex")
                                    .font(.largeTitle)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .padding(.top,40)
                                
                                Spacer()
                                
                                Button{
                                    viewModel.shuffle(forFilter: filterApplied)
                                }
                            label:
                                {
                                    Text("Shuffle")
                                        .padding(.bottom, 9)
                                }
                                
                            }
                            .padding()
                            
                            //MARK: - Pokemon Grid View
                            PokemonGrid(expand: $expand, selection: $selection, filterApplied: $filterApplied, viewModel: viewModel)
                                .blur(radius: showFilterButtons ? 8:0)
                        }
                        //MARK: - Filter Button
                        FilterButtons(showFilterButtons: $showFilterButtons, filterApplied: $filterApplied, viewModel: viewModel)
                        
                    }
                    .navigationBarHidden(true)
                    .ignoresSafeArea(.all)
                    
                }
            }
            //MARK: - Show Expanded View
            else {
                ExpandedCardView(expand: $expand, pokemon: selection)
                
            }
        }
        .transition(.slide)
        .animation(.spring().speed(0.5))
        
    }
}

struct PokemonGrid: View {
    
    //MARK: - Variables
    var gridItems = Array(repeating: GridItem(.flexible()), count: 2)
    
    @Binding var expand: Bool
    @Binding var selection : Pokemon?
    
    @Binding var filterApplied: Bool
    
    @State var animationAmount = 0.0
    @State var rotate = false
    
    @ObservedObject var viewModel: PokeDexViewModel
    
    //MARK: - View
    var body: some View {
        ScrollView(.vertical){
            
            LazyVGrid(columns: gridItems, spacing: 20){
                let dataSource = filterApplied ? viewModel.filteredPokemon : viewModel.pokemons
                
                ForEach(dataSource){ pokemon in
                    PokemonCardView(pokemon: pokemon)
                        .rotation3DEffect(
                            .degrees(animationAmount),
                            axis: (x: 1.0, y: 1.0, z: 0.0)
                        )
                        .gesture(TapGesture()
                            .onEnded{_ in
                                self.selection = pokemon
                                withAnimation(.interpolatingSpring(stiffness: 50, damping: 0.8)){
                                    self.rotate = true
                                    self.animationAmount += 360
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                        self.expand = true
                                    }
                                }
                            }
                                 
                        )
                    
                }
                
                
            }
            
        }
        .animation(.spring())
    }
}

//MARK: - Preview
struct PokeDexView_Previews: PreviewProvider {
    static var previews: some View {
        PokeDexView()
            .preferredColorScheme(.dark)
    }
}
