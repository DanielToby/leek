//
//  words_controller.swift
//  leek
//
//  Created by Daniel Toby on 2/18/22.
//

import Foundation

class WordsController: ObservableObject {
    @Published private var model = WordDatabase()

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
        model.createCurrentWord(word)
        queryOxfordDefinitions(query: word) { [weak self] data in
            self?.model.addDataToCurrentWord(word, data: data)
            print("Collected data for word '\(word)'.")
        }
    }
    
    func addCurrentWord() {
        model.addCurrentWord()
    }
    
    func removeCurrentWord() {
        model.removeCurrentWord()
    }
}
