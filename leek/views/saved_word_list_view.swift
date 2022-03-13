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
        ScrollView {
            if (wordsController.words.isEmpty) {
                Text("Saved Words will appear here.")
            } else {
                ForEach(wordsController.words) { word in
                    NavigationLink(destination: WordView(word: word,
                                                         onSaveFunction: { save(word.word) },
                                                         onUnsaveFunction: { unsave(word.word) })) {
                        Text(word.word)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Leek")
                    .font(Font.custom("CarterOne", size: 32))
                    .padding()
            }
        }
    }
    
    private func save(_ word: String) {
        wordsController.setCurrentWord(word)
        wordsController.addCurrentWord()
    }
    
    private func unsave(_ word: String) {
        wordsController.setCurrentWord(word)
        wordsController.removeCurrentWord()
    }
    
    struct WordListView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewDevice("iPhone 12 Pro")
        }
    }
}
