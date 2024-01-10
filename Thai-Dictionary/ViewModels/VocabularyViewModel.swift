//
//  AllWordsViewModel.swift
//  Thai-Dictionary
//
//  Created by Bandit Silachai on 7/12/23.
//

import SwiftUI
import AVFoundation

final class VocabularyViewModel: ObservableObject {

    @Published var thaiAlphabet: [Alphabet] = thaiAlphabetData
    @Published var popularLists = popularListsData
    @Published var data: [WordElement]?
    @Published var wordByCharacter: WordByCharacter?
    @Published var allvocabs: AllVocabs?
    @Published var currentPage: Int = 1
    @Published var isBusy = false
    @Published var bookmarks: [String] = ["ความชอบ"] {
            didSet {
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }
        }

    func find(vocab: String) {
        isBusy = true
        data = []
        
        NetworkService.shared.findVocab(vocab: vocab) { result in
            switch result {
            case .success(let fetchedData):
                DispatchQueue.main.async {
                    self.data = fetchedData
                    self.isBusy = false
                }
            case .failure(let failure):
                print(failure)
                DispatchQueue.main.async {
                    self.isBusy = false
                }
            }
        }
    }
    
    func getAllVocab() {
        isBusy = true
        NetworkService.shared.allVocab(page: currentPage) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.allvocabs = data
                    self.isBusy = false
                }
            case .failure(let failure):
                print(failure)
                DispatchQueue.main.async {
                    self.isBusy = false
                }
            }
        }
    }
    
    func getAllVocabsNextPage() {
        guard let totalPages = allvocabs?.totalPages else {
             return
        }
        
        if currentPage < totalPages {
            currentPage += 1
            
            NetworkService.shared.allVocab(page: currentPage) { result in
                switch result {
                case .success(let responseData):
                    DispatchQueue.main.async {
                        print(responseData)
                        self.allvocabs?.data.append(contentsOf: responseData.data)
                        self.allvocabs?.currentPage = responseData.currentPage
                        self.allvocabs?.totalPages = responseData.totalPages
                    }
                case .failure(let failure):
                    print(failure)
                    DispatchQueue.main.async {
                        self.isBusy = false
                    }
                }
            }
        }
    }
    
    func findByCharacter(character: String) {
        isBusy = true
        wordByCharacter = []
        
        NetworkService.shared.findByCharacter(character: character) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.wordByCharacter = data
                    self.isBusy = false
                }
            case .failure(let failure):
                print(failure)
                DispatchQueue.main.async {
                    self.isBusy = false
                }
            }
        }
        
    }
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "th-TH")
        utterance.rate = 0.4
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)

    }
    
    func addBookmark(_ vocab: String) {
        if !bookmarks.contains(vocab) {
            bookmarks.append(vocab)
        } else {
            bookmarks.removeAll { value in
                value == vocab
            }
        }
    }
    
    func removeBookmark(at index: IndexSet) {
        bookmarks.remove(atOffsets: index)
    }
    
    func isVocabBookmark(_ vocab: String ) -> Bool {
        return bookmarks.contains(vocab)
    }
}

