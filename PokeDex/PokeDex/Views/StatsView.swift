//
//  StatsView.swift
//  PokeDex
//
//  Created by Tushar Kalra on 02/06/21.
//


import SwiftUI

struct StatsView: View {
    var value: Int = 100
    var title: String = "HP"
    var color: Color = .blue

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
            }.padding(.leading)
        }
    }
}

struct BarChartView: View {
    @Namespace var evolutionTransition
    @State var animationAmount = 0.0
    let pokemon: Pokemon
    var body: some View {
            VStack {
                StatsView(value: pokemon.height, title: "Height", color: .orange)
                StatsView(value: pokemon.attack, title: "Attack", color: .red)
                StatsView(value: pokemon.defense, title: "Defense", color: .blue)
                StatsView(value: pokemon.weight, title: "Weight", color: .purple)
            }
            .rotation3DEffect(
                .degrees(animationAmount),
                axis: (x: 1.0, y: 1.0, z: 1.0)
            )
        .frame(width: 340)
        .padding()
        .background(Color.white.opacity(0.5))
            .shadow(color: .black, radius: 30, x: -10, y:0)
        .matchedGeometryEffect(id: "pokemonStats", in: evolutionTransition)
            .onAppear(perform: {
                animationAmount += 360
            })
            

}
}
struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
