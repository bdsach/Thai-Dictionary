//
//  NetworkService.swift
//  Thai-Dictionary
//
//  Created by Bandit Silachai on 10/1/24.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    func allVocab(page: Int, completion: @escaping(Result<AllVocabs, Error>) -> Void) {
        guard let url = URL(string: "https://thai-dictionary-api.vercel.app/words?page=\(page)&per_page=30") else {
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
                    let words = try decoder.decode(AllVocabs.self, from: data)
                    completion(.success(words))
                } catch let failure {
                    completion(.failure(failure))
                    print("Error decoding JSON: \(failure.localizedDescription)")
                }
            }
            

        }
        .resume()
        
        
        
    }
    
    func findVocab(vocab: String, completion: @escaping(Result<[WordElement], Error>)-> Void) {
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
                    
                    completion(.success(vocabularyList))
                } catch let error {
                    completion(.failure(error))
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
        
    }
    
    func findByCharacter(character: String, completion: @escaping(Result<WordByCharacter, Error>) -> Void) {
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
                    
                    completion(.success(words))
                } catch let failure {
                    completion(.failure(failure))
                    print("Error decoding JSON: \(failure.localizedDescription)")
                }
            }
            

        }
        .resume()
        
    }
}
