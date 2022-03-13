//
//  word_database.swift
//  leek
//
//  Created by Daniel Toby on 2/18/22.
//

import Foundation

struct WordDatabase {
    
    // Saved words are loaded from json at initialization.
    // JSON write happens when words are added / removed.
    // 'currentWord' is stored in memory and represents the current searched / opened word (saved or otherwise)
    
    var words: [Word] = []
    private(set) var currentWord: Word?
    private var currentId = 0
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("scrums.data")
    }
    
    static func load(completion: @escaping (Result<[Word], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let words = try JSONDecoder().decode([Word].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(words))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(words: [Word], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(words)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(words.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    private mutating func getAndIncrementId() -> Int {
        let id = currentId
        currentId += 1
        return id
    }
    
    mutating func setCurrentWord(_ word: String) {
        currentWord = words.first(where: { $0.word == word })
    }
    
    
    mutating func createCurrentWord(_ word: String) {
        let newWord = Word(word: word, id: getAndIncrementId(), isSaved: false)
        currentWord = newWord
    }
    
    mutating func addDataToCurrentWord(_ word: String, data: WordData) {
        if (currentWord?.word == word) {
            currentWord?.data = data
        }
    }
    
    mutating func saveCurrentWord() {
        if var currentWord = currentWord {
            currentWord.isSaved = true
            words.insert(currentWord, at: 0)
            print("Added word '\(currentWord.word)'.")
            self.currentWord?.isSaved = true
        }
    }
    
    mutating func unsaveCurrentWord() {
        if let currentWord = currentWord {
            words.removeAll(where: { $0.word == currentWord.word })
            print("Removed word '\(currentWord.word)'.")
            self.currentWord?.isSaved = false
        }
    }
}
