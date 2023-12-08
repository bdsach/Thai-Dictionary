//
//  Word.swift
//  Thai-Dictionary
//
//  Created by Bandit Silachai on 7/12/23.
//

import Foundation

typealias Word = [WordElement]

// MARK: - Meaning
struct Meaning: Codable {
    let id: Int
    let word: String
    let description: String
    let subwords: [Subword?]
}

// MARK: - Subword
struct Subword: Codable {
    let word: String
}



// MARK: - WordElement
struct WordElement: Codable {
    let id: Int
    let word, description: String
    let subLabel: [String]?
    let subWords: [String]?

    enum CodingKeys: String, CodingKey {
        case id, word, description
        case subLabel = "sub_label"
        case subWords = "sub_words"
    }
}


// MARK: - WordByCharacter
typealias WordByCharacter = [String]

struct Alphabet: Hashable {
    let icon: String
    let character: String
}
