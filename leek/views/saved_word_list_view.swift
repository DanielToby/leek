//
//  saved_word_list_view.swift
//  leek
//
//  Created by Daniel Toby on 2/18/22.
//

import SwiftUI

struct SavedWordListView: View {
    @ObservedObject var wordsController: WordsController
    @Binding var isSheetVisible: Bool
    
    var body: some View {
        if (wordsController.words.isEmpty) {
            Text("Saved Words will appear here.")
        } else {
            List {
                ForEach(wordsController.words) { word in
                    SavedWordListItemView(word: word,
                                          onSaveFunction: wordsController.saveCurrentWord,
                                          onUnsaveFunction: wordsController.unsaveCurrentWord
                    )
                        .contentShape(Rectangle())
                        .onTapGesture {
                            wordsController.setCurrentWord(word.word)
                            isSheetVisible = true
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
