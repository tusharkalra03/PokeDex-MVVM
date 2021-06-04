//
//  PokeDexView.swift
//  PokeDex
//
//  Created by Tushar Kalra on 01/06/21.
//

import SwiftUI

struct PokeDexView: View {
    
    private var gridItems = Array(repeating: GridItem(.flexible()), count: 2)
    
    
    @Namespace var expandTransition
    @Namespace var rotateTransition

    @State var expand = false
    @State var selection : Pokemon?
    
    @State var showFilterButtons = false
    @State var filterApplied = false
    
    @State var animationAmount = 0.0
    @State var rotate = false

    @ObservedObject var viewModel = PokeDexViewModel()
    
    
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
                                
                                Button(action: {viewModel.shuffle()
                                    self.animationAmount += 360
                                }){
                                    Text("Shuffle")
                                        .padding(.bottom, 9)
                                }
                                
                                
                                
                            }
                            .padding()
                            
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
                        
                        VStack {
                            if showFilterButtons {
                                FilterButtonView(imageName: "flame", backgroundColor: .red, show: $showFilterButtons) {
                                    filterApplied.toggle()
                                    showFilterButtons.toggle()
                                    viewModel.filterPokemon(by: "fire")
                                }
                                FilterButtonView(imageName: "leaf", backgroundColor: .green, show: $showFilterButtons) {
                                    filterApplied.toggle()
                                    showFilterButtons.toggle()
                                    viewModel.filterPokemon(by: "poison")
                                    
                                }
                                FilterButtonView(imageName: "drop", backgroundColor: .blue, show: $showFilterButtons) {
                                    filterApplied.toggle()
                                    showFilterButtons.toggle()
                                    viewModel.filterPokemon(by: "water")
                                    
                                }
                                FilterButtonView(imageName: "bolt", backgroundColor: .yellow, show: $showFilterButtons) {
                                    filterApplied.toggle()
                                    showFilterButtons.toggle()
                                    viewModel.filterPokemon(by: "electric")
                                }
                            }
                            
                            let imageName = filterApplied ? "multiply" : "line.horizontal.3.decrease"
                            FilterButtonView(imageName: imageName, height: 36, width: 36, show: $showFilterButtons) {
                                filterApplied ? filterApplied.toggle() : showFilterButtons.toggle()
                            }.rotationEffect(.init(degrees: self.showFilterButtons ? 180 : 0))
                            
                        }
                        .padding()
                        .animation(.spring())
                        
                    }
                    .navigationBarHidden(true)
                    .ignoresSafeArea(.all)
                    
                }
            } else {
                ExpandedCardView(pokemon: selection ?? Pokemon(id: 0, name: "", type: "", imageUrl: "", description: "", evolutionChain: nil, height: 0, weight: 0, attack: 0, defense: 0))
                    .gesture(DragGesture().onEnded({ _ in
                        withAnimation(.easeOut){
                            self.expand = false
                        }
                        
                    })
                    )
            }
        }
       .transition(.slide)
       .animation(.spring().speed(0.5))
        
    }
}


struct PokeDexView_Previews: PreviewProvider {
    static var previews: some View {
        PokeDexView()
    }
}
