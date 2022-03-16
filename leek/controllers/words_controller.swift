//
//  words_controller.swift
//  leek
//
//  Created by Daniel Toby on 2/18/22.
//

import Foundation

class WordsController: ObservableObject {
    @Published var currentWord: Word? // Last defined / opened word. Can be the same as _wordOfTheDay.
    @Published private(set) var wordOfTheDay: Word?
    @Published private var wordDatabase = WordDatabase()
    
    init() {
        let wordOfTheDay = "Gastropod"
        createWordOfTheDay(wordOfTheDay)
        loadDatabase()
    }
    
    private func createWordOfTheDay(_ word: String) {
        if (wordDatabase.words.contains(where: { $0.id == word })) {
            wordOfTheDay = wordDatabase.words.first(where: { $0.id == word })
        } else {
            wordOfTheDay = Word(id: word, isSaved: false)
            queryOxfordDefinitions(query: word) { [self] data in
                self.wordOfTheDay?.data = data
                print("Collected data for word '\(word)'.")
            }
        }
    }
    
    private func saveDatabase() {
        WordDatabase.save(words: wordDatabase.words) { result in
            switch result {
            case .failure(let error):
                fatalError(error.localizedDescription)
            case .success(let count):
                print("Stored \(count) words in database.")
            }
        }
    }
    
    private func loadDatabase() {
        WordDatabase.load { [self] result in
            switch result {
            case .failure(let error):
                fatalError(error.localizedDescription)
            case .success(let words):
                for word in words {
                    if word.id == wordOfTheDay?.id {
                        wordOfTheDay?.isSaved = true
                    }
                    wordDatabase.addWord(word)
                }
                print("Loaded \(words.count) words from database.")
            }
        }
    }
    
    var savedWords: Array<Word> {
        return wordDatabase.words
    }

    // Sets the currentWord depending on whether it is the word of the day, saved, or a new search.
    func lookup(_ word: String) {
        if let wordOfTheDay = wordOfTheDay, wordOfTheDay.id == word {
            currentWord = wordOfTheDay
        } else if (wordDatabase.words.contains(where: { $0.id == word })) {
            currentWord = wordDatabase.words.first(where: { $0.id == word })
        } else {
            currentWord = Word(id: word, isSaved: false)
            queryOxfordDefinitions(query: word) { [self] data in
                self.currentWord?.data = data
                print("Collected data for word '\(word)'.")
            }
        }
    }
    
    func toggleCurrentWordIsSaved() {
        currentWord?.isSaved.toggle()
        if let currentWord = currentWord {
            if currentWord.isSaved {
                wordDatabase.addWord(currentWord)
            } else {
                wordDatabase.removeWord(currentWord)
            }
            saveDatabase()
            
            if currentWord.id == wordOfTheDay?.id {
                wordOfTheDay?.isSaved = currentWord.isSaved
            }
        }
    }
    
    func toggleWordOfTheDayIsSaved() {
        wordOfTheDay?.isSaved.toggle()
        if let wordOfTheDay = wordOfTheDay {
            if wordOfTheDay.isSaved {
                wordDatabase.addWord(wordOfTheDay)
            } else {
                wordDatabase.removeWord(wordOfTheDay)
            }
            saveDatabase()
            
            if wordOfTheDay.id == currentWord?.id {
                currentWord?.isSaved = wordOfTheDay.isSaved
            }
        }
    }
    
}
