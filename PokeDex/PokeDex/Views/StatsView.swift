//
//  StatsView.swift
//  PokeDex
//
//  Created by Tushar Kalra on 02/06/21.
//


import SwiftUI

struct StatsView: View {
    //MARK: - Variables
    var value: Int
    var title: String
    var color: Color
    
    //MARK: - View
    var body: some View {
        
        HStack {
            Text(title)
                .padding(.leading, 32)
                .font(.headline)
                .foregroundColor(.black)
                .frame(width: 100)
            
            HStack {
                Text("\(value)")
                    .frame(width: 40)
                    .padding(.trailing)
                
                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(width: 180, height: 20).animation(.default)
                        .foregroundColor(Color(.systemGray5))
                    
                    Capsule()
                        .frame(width: value > 250 ? CGFloat(200) : CGFloat(value), height: 20).animation(.default)
                        .foregroundColor(color)
                }
                Spacer()
            }
            .padding(.leading)
        }
    }
}

struct BarChartView: View {
    //MARK: - Variables
    let pokemon: Pokemon
    @Binding var showStats: Bool
    
    @Namespace var evolutionTransition
    @State var animationAmount = 0.0
    
    //MARK: - View
    var body: some View {
        VStack {
            VStack {
                StatsView(value: pokemon.height, title: "Height", color: .orange)
                StatsView(value: pokemon.attack, title: "Attack", color: .red)
                StatsView(value: pokemon.defense, title: "Defense", color: .blue)
                StatsView(value: pokemon.weight, title: "Weight", color: .purple)
                
            }
            .frame(width: 340)
            .padding()
            .background(Color.white.opacity(0.5))
            .shadow(color: .black, radius: 30, x: -10, y:0)
            .matchedGeometryEffect(id: "pokemonStats", in: evolutionTransition)
            .onAppear(perform: {
                animationAmount += 360
            })
            
            Button {
                showStats.toggle()
            }
            label: {
                Image(systemName: "multiply")
                    .font(.body)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.white.opacity(0.4))
                    .clipShape(Circle())
            }
        }
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 1.0, y: 1.0, z: 1.0)
        )
       

    }
}
//MARK: - Preview
struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(value: 60, title: "Power", color: .blue)
    }
}
