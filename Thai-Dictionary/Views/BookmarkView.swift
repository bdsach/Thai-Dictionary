//
//  BookmarkView.swift
//  Thai-Dictionary
//
//  Created by Bandit Silachai on 8/12/23.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject private var vm: VocabularyViewModel
    
    var body: some View {
        NavigationView {
            HStack {
                if vm.bookmarks.isEmpty {
                    HStack {
                        Image(systemName: "bookmark.slash")
                            .foregroundColor(.blue)
                        Text("ยังไม่มีบุ๊คมาร์ก")
                    }
                    .font(.title2)
                } else {
                    List {
                        ForEach(vm.bookmarks, id: \.self) { item in
                            NavigationLink {
                                DetailView(vocab: item)
                            } label: {
                                Text(item)
                            }
                            
                        }
                        .onDelete(perform: { indexSet in
                            print(indexSet)
                            vm.removeBookmark(at: indexSet)
                        })
                    }
                }
            }
            .navigationTitle("บุ๊คมาร์ก")
        }
    }
}

#Preview {
    BookmarkView()
        .environmentObject(VocabularyViewModel())
}
