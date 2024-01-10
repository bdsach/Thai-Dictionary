//
//  AllWords.swift
//  Thai-Dictionary
//
//  Created by Bandit Silachai on 7/12/23.
//

import SwiftUI

struct AllVocabsView: View {
    @State private var keyword = ""
    @EnvironmentObject private var vm: VocabularyViewModel
    
    var body: some View {

        NavigationView(content: {
            List {
                if vm.isBusy {
                    ProgressView()
                } else {
                    if let vocabs = vm.allvocabs {
                        ForEach(vocabs.data, id: \.self) { item in
                            NavigationLink {
                                DetailView(vocab: item)
                            } label: {
                                Text(item)
                            }
                            .onAppear(){
                                if (vocabs.data.last == item){
                                    vm.getAllVocabsNextPage()
                                }
                            }
                        }
                    }
                }
            }
            .refreshable {
                print("refresh")
                vm.currentPage = 1
                vm.getAllVocab()
            }
            .listStyle(.plain)
            .navigationTitle("คำศัพท์ทั้งหมด")
            .onAppear {
                vm.getAllVocab()
            }
            .safeAreaPadding(.bottom, 30)
        })
    }
    
}

#Preview {
    AllVocabsView()
}
