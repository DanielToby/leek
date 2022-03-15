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
    
    func setCurrentWord(_ word: String) {
        model.setCurrentWord(word)
    }
    
    func define(_ word: String) {
        if (model.words.contains(where: { $0.word == word })) {
            model.setCurrentWord(word)
        } else {
            model.createCurrentWord(word)
            queryOxfordDefinitions(query: word) { [weak self] data in
                self?.model.addDataToCurrentWord(word, data: data)
                print("Collected data for word '\(word)'.")
            }
        }
    }
    
    func saveCurrentWord() {
        model.saveCurrentWord()
        WordDatabase.save(words: model.words) { result in
            switch result {
            case .failure(let error):
                fatalError(error.localizedDescription)
            case .success(let count):
                print("Stored \(count) words in database.")
            }
        }
    }
    
    func unsaveCurrentWord() {
        model.unsaveCurrentWord()
        WordDatabase.save(words: model.words) { result in
            switch result {
            case .failure(let error):
                fatalError(error.localizedDescription)
            case .success(let count):
                print("Stored \(count) words in database.")
            }
        }
    }
}
