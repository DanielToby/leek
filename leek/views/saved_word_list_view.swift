//
//  saved_word_list_view.swift
//  leek
//
//  Created by Daniel Toby on 2/18/22.
//

import SwiftUI

struct SavedWordListView: View {
    @ObservedObject var wordsController: WordsController
    
    var body: some View {
        if (wordsController.words.isEmpty) {
            Text("Saved Words will appear here.")
        } else {
            List {
                ForEach(wordsController.words) { word in
                    NavigationLink {
                        WordView(word: word,
                                 onSaveFunction: {
                            wordsController.setCurrentWord(word.word)
                            wordsController.saveCurrentWord()
                        },
                                 onUnsaveFunction: {
                            wordsController.setCurrentWord(word.word)
                            wordsController.unsaveCurrentWord()
                        })
                    } label: {
                        SavedWordListItemView(word: word,
                                              onSaveFunction: {
                            wordsController.setCurrentWord(word.word)
                            wordsController.saveCurrentWord()
                        },
                                              onUnsaveFunction: {
                            wordsController.setCurrentWord(word.word)
                            wordsController.unsaveCurrentWord()
                            
                        })
                    }
                }
            }
        }
    }
    
    struct WordListView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewDevice("iPhone 12 Pro")
        }
    }
}
