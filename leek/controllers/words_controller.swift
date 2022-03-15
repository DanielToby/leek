//
//  words_controller.swift
//  leek
//
//  Created by Daniel Toby on 2/18/22.
//

import Foundation

class WordsController: ObservableObject {
    @Published private var model = WordDatabase()
    
    init() {
        let wordOfTheDay = "Gastropod"
        setWordOfTheDay(wordOfTheDay)
        loadDatabase()
    }
    
    private func saveDatabase() {
        WordDatabase.save(words: model.words) { result in
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
                model.words = words
                print("Loaded \(words.count) words from database.")
            }
        }
    }
    
    var words: Array<Word> {
        return model.words
    }
    
    var currentWord: Word? {
        return model.currentWord
    }
    
    var wordOfTheDay: Word? {
        return model.wordOfTheDay
    }
    
    func setCurrentWord(_ word: String) {
        model.setCurrentWord(word)
    }
    
    func define(_ word: String) {
        if (model.words.contains(where: { $0.word == word })) {
            model.setCurrentWord(word)
        } else {
            model.createCurrentWord(word)
            queryOxfordDefinitions(query: word) { [weak self] data in
                self?.model.addDataToCurrentWord(data)
                print("Collected data for word '\(word)'.")
            }
        }
    }
    
    func setWordOfTheDay(_ word: String) {
        model.createWordOfTheDay(word)
        queryOxfordDefinitions(query: word) { [weak self] data in
            self?.model.addDataToWordOfTheDay(data)
            print("Collected data for word '\(word)'.")
        }
    }
    
    func saveCurrentWord() {
        model.saveCurrentWord()
        saveDatabase()
    }
    
    func unsaveCurrentWord() {
        model.unsaveCurrentWord()
        saveDatabase()
    }
    
    func saveWordOfTheDay() {
        model.saveWordOfTheDay()
        saveDatabase()
    }
    
    func unsaveWordOfTheDay() {
        model.unsaveWordOfTheDay()
        saveDatabase()
    }
    
}
