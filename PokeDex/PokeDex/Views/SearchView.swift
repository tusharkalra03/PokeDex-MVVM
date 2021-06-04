//
//  SearchView.swift
//  PokeDex
//
//  Created by Tushar Kalra on 02/06/21.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var text: String
    @State private var isEditing = false
    var body: some View {
        VStack{
            HStack{
                TextField("Search by name...",text: $text)
                    .autocapitalization(.words)
                    .padding(15)
                    .padding(.horizontal, 25)
                    .foregroundColor(.black)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                                .padding(.leading, 15)
                            
                            if isEditing{
                                Button(action: {self.text = ""}){
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                            
                        }
                    ).onTapGesture {
                        self.isEditing = true
                    }
                
                if isEditing{
                    Button(action: {
                        self.isEditing = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }){
                        Text("Cancel")
                    }
                }
            }
            .padding()
            
            VStack{
                HStack{
                    Text("Poison")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12.0)
                            .fill(Color.gray.opacity(0.5))
                    )
                    Text("Fire")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12.0)
                            .fill(Color.gray.opacity(0.5))
                    )
                    Text("Water")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12.0)
                            .fill(Color.gray.opacity(0.5))
                    )
                }
                HStack{
                    Text("Electric")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12.0)
                            .fill(Color.gray.opacity(0.5))
                    )
                    Text("Psychic")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12.0)
                            .fill(Color.gray.opacity(0.5))
                    )
                    Text("Normal")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12.0)
                            .fill(Color.gray.opacity(0.5))
                    )
                }
                HStack{
                    Text("Ground")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12.0)
                            .fill(Color.gray.opacity(0.5))
                    )
                    Text("Flying")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12.0)
                            .fill(Color.gray.opacity(0.5))
                    )
                    Text("Fairy")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12.0)
                            .fill(Color.gray.opacity(0.5))
                    )
                }
            }
            
            Button(action:{}){
                Text("Search")
            }
        }
    }
}

//struct SearchView_Previews: PreviewProvider{
//    static var previews: some View {
//        SearchView(text: )
//    }
//}
