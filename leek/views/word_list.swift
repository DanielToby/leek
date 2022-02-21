//
//  word_list.swift
//  leek
//
//  Created by Daniel Toby on 2/18/22.
//

import Foundation

class WordList: ObservableObject {
    @Published private var model = WordDatabase()

    var savedWords: Array<Word> {
        return model.savedWords
    }
    
    var searchedWords: Array<Word> {
        return model.searchedWords
    }
    
    func saveWord(_ word: Word) {
        model.saveWord(word)
    }
    
    func expandWord(_ word: Word) {
        model.expandWord(word)
    }
    
    func searchFor(_ wordName: String) {
        model.searchFor(wordName)
    }
}
