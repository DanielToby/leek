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
    
    private(set) var words: [Word] = []
    
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
    
    mutating func addWord(_ word: Word) {
        if (!words.contains(where: { $0.id == word.id })) {
            let newWord = Word(id: word.id, data: word.data, isSaved: true)
            words.insert(newWord, at: 0)
            print("Added word '\(newWord.id)'.")
        }
    }
    
    mutating func removeWord(_ word: Word) {
        words.removeAll(where: { $0.id == word.id })
        print("Removed word '\(word.id)'.")
    }
}
