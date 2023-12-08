//
//  BookmarkView.swift
//  Thai-Dictionary
//
//  Created by Bandit Silachai on 8/12/23.
//

import SwiftUI

struct BookmarkView: View {
    var body: some View {
        NavigationView(content: {
            NavigationLink(destination: Text("Destination")) { Text("Navigate") }
        })
    }
}

#Preview {
    BookmarkView()
}
