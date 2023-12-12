//
//  Thai_DictionaryApp.swift
//  Thai-Dictionary
//
//  Created by Bandit Silachai on 7/12/23.
//

import SwiftUI

@main
struct Thai_DictionaryApp: App {
    @StateObject var viewModel = VocabularyViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
        }
    }
}
