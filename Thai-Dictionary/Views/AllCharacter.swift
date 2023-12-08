//
//  AllCharacter.swift
//  Thai-Dictionary
//
//  Created by Bandit Silachai on 8/12/23.
//

import SwiftUI

struct AllCharacter: View {
    @ObservedObject private var vm = AllWordsViewModel()
    
    var body: some View {
        NavigationView(content: {
            List {
                ForEach(vm.thaiAlphabet, id: \.self) { item in
                    NavigationLink {
                        DetailCharacter(character: item.character)
                    } label: {
                        Text(item.character)
                    }
                }
                .font(.title3)
                .fontWeight(.light)
            }
            .listStyle(.plain)
            .navigationTitle("คำศัพท์ตามอักษร")
        })
    }
}

#Preview {
    AllCharacter()
}

struct DetailCharacter: View {
    @ObservedObject private var vm = AllWordsViewModel()
    @State var character: String
    
    
    
    var body: some View {
        List {
            if let wordByCharacter = vm.wordByCharacter {
                ForEach(wordByCharacter, id: \.self) { item in
                    NavigationLink {
                        DetailView(vocab: item)
                    } label: {
                        Text(item)
                            .fontWeight(.light)
                            .font(.title3)
                    }
                    
                }
            }
        }
        .navigationTitle(character)
        .listStyle(.plain)
        .onAppear(perform: {
            vm.findByCharacter(character: character)
        })
    }
}
