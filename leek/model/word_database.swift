//
//  word_database.swift
//  leek
//
//  Created by Daniel Toby on 2/18/22.
//

import Foundation

struct WordDatabase {
    
    // Saved words are loaded from json at initialization.
    // JSON write happens when words are added.
    // Searched words is reconstructed on every search().
    
    private(set) var words: Array<Word> = []
    private(set) var currentWord: Word?

    private var currentId = 0
    
    private mutating func getAndIncrementId() -> Int {
        let id = currentId
        currentId += 1
        return id
    }
    
    mutating func setCurrentWord(_ word: String) {
        currentWord = words.first(where: { $0.word == word })
    }
    
    mutating func addCurrentWord() {
        if var currentWord = currentWord {
            currentWord.isSaved = true
            words.insert(currentWord, at: 0)
            print("Added word '\(currentWord.word)'.")
            self.currentWord?.isSaved = true
        }
    }
    
    mutating func removeCurrentWord() {
        if let currentWord = currentWord {
            words.removeAll(where: { $0.word == currentWord.word })
            print("Removed word '\(currentWord.word)'.")
            self.currentWord?.isSaved = false
        }
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
}
