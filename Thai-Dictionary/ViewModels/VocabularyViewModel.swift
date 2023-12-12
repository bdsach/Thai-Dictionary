//
//  AllWordsViewModel.swift
//  Thai-Dictionary
//
//  Created by Bandit Silachai on 7/12/23.
//

import SwiftUI
import AVFoundation

class VocabularyViewModel: ObservableObject {
    
    let thaiAlphabet: [Alphabet] = [
        Alphabet(icon: "🐓", character: "ก"),
        Alphabet(icon: "🥚", character: "ข"),
        Alphabet(icon: "🍾", character: "ฃ"),
        Alphabet(icon: "🐃", character: "ค"),
        Alphabet(icon: "👨‍👩‍👧‍👦", character: "ฅ"),
        Alphabet(icon: "🔔", character: "ฆ"),
        Alphabet(icon: "🐍", character: "ง"),
        Alphabet(icon: "🍛", character: "จ"),
        Alphabet(icon: "", character: "ฉ"),
        Alphabet(icon: "🐘", character: "ช"),
        Alphabet(icon: "⛓️", character: "ซ"),
        Alphabet(icon: "🌳", character: "ฌ"),
        Alphabet(icon: "💃", character: "ญ"),
        Alphabet(icon: "", character: "ฎ"),
        Alphabet(icon: "", character: "ฏ"),
        Alphabet(icon: "", character: "ฐ"),
        Alphabet(icon: "", character: "ฑ"),
        Alphabet(icon: "", character: "ฒ"),
        Alphabet(icon: "", character: "ณ"),
        Alphabet(icon: "", character: "ด"),
        Alphabet(icon: "", character: "ต"),
        Alphabet(icon: "", character: "ถ"),
        Alphabet(icon: "", character: "ท"),
        Alphabet(icon: "", character: "ธ"),
        Alphabet(icon: "", character: "น"),
        Alphabet(icon: "", character: "บ"),
        Alphabet(icon: "", character: "ป"),
        Alphabet(icon: "", character: "ผ"),
        Alphabet(icon: "", character: "ฝ"),
        Alphabet(icon: "", character: "พ"),
        Alphabet(icon: "", character: "ฟ"),
        Alphabet(icon: "", character: "ภ"),
        Alphabet(icon: "", character: "ม"),
        Alphabet(icon: "", character: "ย"),
        Alphabet(icon: "", character: "ร"),
        Alphabet(icon: "", character: "ล"),
        Alphabet(icon: "", character: "ว"),
        Alphabet(icon: "", character: "ศ"),
        Alphabet(icon: "", character: "ษ"),
        Alphabet(icon: "", character: "ส"),
        Alphabet(icon: "", character: "ห"),
        Alphabet(icon: "", character: "ฬ"),
        Alphabet(icon: "", character: "อ"),
        Alphabet(icon: "", character: "ฮ")
    ]

    
    let popularLists = [
        "กกเสา",
        "กฎเกณฑ์",
        "กงวาน",
        "กช-",
        "กฎบัตรสหประชาชาติ",
        "ก้นกบ",
    ]
    
    @Published var bookmarks: [String] = ["ความชอบ"]
    @Published var data: [WordElement]?
    @Published var wordByCharacter: WordByCharacter?
    
    func find(vocab: String) {
        
        guard let url = URL(string: "https://thai-dictionary-api.vercel.app/lookup") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let bodyData = "keyword=\(vocab)".data(using: .utf8)
        request.httpBody = bodyData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            

            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let vocabularyList = try decoder.decode([WordElement].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.data = vocabularyList
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
        
    }
    
    func findAll() {
        
    }
    
    func findByCharacter(character: String) {
        guard let url = URL(string: "https://thai-dictionary-api.vercel.app/character/\(character)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let words = try decoder.decode(WordByCharacter.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.wordByCharacter = words
                        print(words)
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
            

        }
        .resume()
        
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

