//
//  ContentView.swift
//  Thai-Dictionary
//
//  Created by Bandit Silachai on 7/12/23.
//

import SwiftUI

struct HomeView: View {
    @State var search = ""
    @EnvironmentObject private var vm: VocabularyViewModel
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label("ค้นหา", systemImage: "magnifyingglass")
                }
            AllCharacter()
                .tabItem {
                    Label("คำศัพท์ตามอักษร", systemImage: "character.book.closed.fill.th")
                }
            
            AllWordsView()
                .tabItem {
                    Label("คำศัพท์ทั้งหมด", systemImage: "list.bullet")
                }
            
            BookmarkView()
                .tabItem {
                    Label("บุ๊คมาร์ก", systemImage: "bookmark")
                }
        }
         
        
    }
}

#Preview {
    HomeView()
}
