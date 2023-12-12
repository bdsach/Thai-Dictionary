//
//  AllWords.swift
//  Thai-Dictionary
//
//  Created by Bandit Silachai on 7/12/23.
//

import SwiftUI

struct AllWordsView: View {
    @State private var keyword = ""
    @EnvironmentObject private var vm: VocabularyViewModel
    
    var body: some View {

        NavigationView(content: {
            List {
//                ForEach(vm.thaiWords, id: \.word) { item in
//                    NavigationLink {
//                        DetailView(vocab: item.word)
//                    } label: {
//                        Text(item.word)
//                    }
//                }
            }
            .listStyle(.plain)
            .navigationTitle("คำศัพท์ทั้งหมด")
        })
    }
    
}

#Preview {
    AllWordsView()
}
