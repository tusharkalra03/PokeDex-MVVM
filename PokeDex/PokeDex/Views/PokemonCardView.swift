//
//  PokemonCardView.swift
//  PokeDex
//
//  Created by Tushar Kalra on 01/06/21.
//

import SwiftUI
import Kingfisher

struct PokemonCardView: View {
    //MARK: - Variables
    @Namespace var expandTransition
    @State var pokemon: Pokemon
    
    //MARK: - View
    var body: some View {
        
        ZStack {
            VStack {
                
                KFImage(URL(string: pokemon.imageUrl))
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top)
                    .padding(.horizontal)
                    .shadow(color: .white, radius: 20)
                
                VStack(alignment: .center) {
                    
                    Text(pokemon.name.capitalized)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(pokemon.type.capitalized)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 12.0)
                                .fill(Color.white.opacity(0.2))
                        )
                }
                .padding()
            }
        }
        .frame(width: 170)
        .background(Color(bgColor(forType: pokemon.type)))
        .cornerRadius(12)
        .shadow(color: Color(bgColor(forType: pokemon.type)),radius: 8)
        .matchedGeometryEffect(id: "pokemonCard", in: expandTransition)
        
    }
    
}
