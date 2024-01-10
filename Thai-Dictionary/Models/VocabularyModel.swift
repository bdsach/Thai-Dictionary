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

// MARK: - AllVocabs
struct AllVocabs: Codable {
    var data: [String]
    var currentPage, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case data
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
}

let thaiAlphabetData: [Alphabet] = [
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

let popularListsData = [
    "กกเสา",
    "กฎเกณฑ์",
    "กงวาน",
    "กช-",
    "กฎบัตรสหประชาชาติ",
    "ก้นกบ",
]
