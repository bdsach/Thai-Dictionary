//
//  Detail.swift
//  Thai-Dictionary
//
//  Created by Bandit Silachai on 7/12/23.
//

import SwiftUI

struct DetailView: View {
    @State var vocab: String
    @EnvironmentObject private var vm: VocabularyViewModel
    
    var body: some View {
        
        VStack(alignment:.leading) {
            HStack {
                Text(vocab)
                    .font(.system(size: 40).bold())
                Button(action: {
                    vm.speak(vocab)
                }, label: {
                    Image(systemName: "speaker.wave.3.fill")
                        .font(.title)
                        .foregroundStyle(.blue)
                })
                Button(action: {
                    withAnimation {
                        vm.addBookmark(vocab)
                    }
                    
                }, label: {
                    Image(systemName: vm.isVocabBookmark(vocab) ? "bookmark.fill" : "bookmark")
                        .font(.title)
                        .foregroundStyle(.blue)
                })
            }
            .padding(.bottom, 10)

            ScrollView {
                VStack(spacing: 18) {
                    if let detail = vm.data {
                        ForEach(detail, id: \.id) { item in
                            VStack {
                                DetailBodyView(item: item, vocab: $vocab)
                            }
                            
                        }
                    }
                }
            }
            
            
        }
        .padding()
        .onAppear(perform: {
            vm.find(vocab: vocab)
        })
        .onChange(of: vocab, initial: true) { oldValue, newValue  in
            vm.find(vocab: newValue)
        }
        
        Spacer()
    }
}

#Preview {
    DetailView(vocab: "ความ")
        .environmentObject(VocabularyViewModel())
}

struct DetailBodyView: View {
    
    var item: WordElement
    @Binding var vocab: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(item.word)
                .font(.title2).bold()
            
            Text(item.description)
                .opacity(0.7)
                .padding(.bottom, 10)
            
            if let subLabel = item.subLabel {
                VStack(alignment: .leading, spacing: 6) {
                    Text(subLabel[0])
                        .font(.title3).bold()
                }
            }
            
            if let subwords = item.subWords {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(subwords, id: \.self) { item in
                            Button {
                                self.vocab = item
                            } label: {
                                Text(item)
                            }
                        }
                        
                    }
                }
            }
        }
        
        .padding(.all, 8)
        .frame(minWidth: 0,
               maxWidth: .infinity,
               alignment: .topLeading
        )
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        
    }
}
