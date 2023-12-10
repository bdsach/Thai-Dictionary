//
//  BookmarkView.swift
//  Thai-Dictionary
//
//  Created by Bandit Silachai on 8/12/23.
//

import SwiftUI

struct BookmarkView: View {
    var body: some View {
        NavigationView {
            HStack {
                Image(systemName: "bookmark.slash.fill")
                Text("ยังไม่มีบุ๊คมาร์ก")
            }
            .navigationTitle("บุ๊คมาร์ก")
            
        }
    }
}

#Preview {
    BookmarkView()
}
