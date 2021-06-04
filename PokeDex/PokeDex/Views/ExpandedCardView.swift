//
//  ExpandedCardView.swift
//  PokeDex
//
//  Created by Tushar Kalra on 01/06/21.
//

import SwiftUI
import Kingfisher

struct ExpandedCardView: View {
    
    @Namespace var expandTransition
    @Namespace var evolutionTransition

    
    let pokemon: Pokemon
    @State var showEvolution = false
    @State var showStats = false
    @State var animationAmount = 0.0
    @State var rotate = false

    @ObservedObject var viewModel = PokeDexViewModel()

    var body: some View {

      return  ZStack{
            VStack(spacing: 40) {
                HStack {
                    Text(pokemon.name.capitalized)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)

                    Spacer()
                }
                .padding(.top,48)

                KFImage(URL(string: pokemon.imageUrl))
                    .shadow(color: .white, radius: 40)
                
                Text(pokemon.description.replacingOccurrences(of: "\n", with: " "))
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                HStack{
                if !showEvolution{
                    VStack {
                        Text("Show Evolution")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 12.0)
                                .fill(Color.white.opacity(0.2))
                        ).onTapGesture {
                            withAnimation(.spring()){
                                self.showEvolution = true
                            }
                    }
                    }
                    .matchedGeometryEffect(id: "pokemonEvolution", in: evolutionTransition)

                }
                
                if !showStats{
                    VStack {
                        Text("Show Stats")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 12.0)
                                .fill(Color.white.opacity(0.2))
                        ).onTapGesture {
                            withAnimation(.spring()){
                                self.showStats = true
                            }
                    }
                    }
                    .matchedGeometryEffect(id: "pokemonStats", in: evolutionTransition)

                }
                }
                
                Spacer()
                
                
            }
            .padding()
            .blur(radius : showEvolution ? 16 : 0)
            .blur(radius : showStats ? 16 : 0)


        
        if showEvolution{
            
            EvolutionView(pokemon: pokemon, viewModel: viewModel)
                .onTapGesture {
                    withAnimation(.easeOut){
                    self.showEvolution = false
                    }
                }
            }
        
        if showStats{
            BarChartView(pokemon: pokemon)
                .onTapGesture {
                    withAnimation(.default){
                    self.showStats = false
                    }
                }
            
        }
        
        }
        .padding()
        .background(Color(bgColor(forType: pokemon.type)))
        .ignoresSafeArea(.all)
        .matchedGeometryEffect(id: "pokemonCard", in: expandTransition)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct EvolutionView: View {
    
    let pokemon: Pokemon
    @ObservedObject var viewModel: PokeDexViewModel
    @Namespace var evolutionTransition
    
    @State var animationAmount = 0.0
    
    
    var body: some View {
        
      
        let evolutionChain = viewModel.evolutionChain(of: pokemon)
        
        return
            HStack{
                if evolutionChain.count > 0 {
                    ForEach(evolutionChain){pokemon in
                        PokemonCardView(pokemon: pokemon)
                    }
                } else {
                    Text("Not available")
                }
            }
            .rotation3DEffect(
                .degrees(animationAmount),
                axis: (x: 1.0, y: 1.0, z: 1.0)
            )
        .frame(width: 360)
        .cornerRadius(20)
        .padding(.vertical)
        .padding(.horizontal, 8)
        .background(Color.white.opacity(0.5))
            .shadow(color: .white, radius: 30)
        .matchedGeometryEffect(id: "pokemonEvolution", in: evolutionTransition)
            .onAppear(perform: {
                animationAmount += 360
            })
        
    }
}
