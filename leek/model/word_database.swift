//
//  word_database.swift
//  leek
//
//  Created by Daniel Toby on 2/18/22.
//

import Foundation

struct WordDatabase {
    private var currentId = 0 // Unique identifier used for both savedWords and searchedWords
    
    // Saved words are loaded from json at initialization.
    // After, they are only added to from the searched words. JSON write also happens at that time.
    // Searched words is reconstructed on every search().
    
    private(set) var savedWords: Array<Word> = []
    private(set) var searchedWords: Array<Word> = []
    
    mutating func expandWord(_ word: Word) {
        if let chosenIndex = savedWords.firstIndex(where: { $0.id == word.id }) {
            savedWords[chosenIndex].isExpanded.toggle()
        } else if let chosenIndex = searchedWords.firstIndex(where: { $0.id == word.id }) {
            searchedWords[chosenIndex].isExpanded.toggle()
        }
    }
    
    mutating func searchFor(_ wordName: String) {
        searchedWords.removeAll()
        let searchResults = [wordName, "New", "Nickle", "Nap"]
        for name in searchResults {
            let phoneticSpelling = "What * ev * er"
            let definitions = ["The meaning of a word; what it most commonly represents."]
            searchedWords.append(Word(name: name,
                                      phoneticSpelling: phoneticSpelling,
                                      definitions: definitions,
                                      id: currentId))
            currentId += 1
        }
    }
    
    mutating func saveWord(_ word: Word) {
        if let chosenIndex = searchedWords.firstIndex(where: { $0.id == word.id }) {
            savedWords.insert(searchedWords.remove(at: chosenIndex), at: 0)
        }
    }
}
