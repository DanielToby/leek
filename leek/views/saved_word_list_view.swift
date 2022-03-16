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
        List {
            Section(header:
                        Text("Saved words:")
                        .font(Font.custom("CarterOne", size: 16))
                        .foregroundColor(.gray)) {
                
                ForEach(wordsController.savedWords) { word in
                    SavedWordListItemView(word: word, onToggleSave: {
                        wordsController.currentWord = word
                        wordsController.toggleCurrentWordIsSaved()
                    })
                        .contentShape(Rectangle())
                        .onTapGesture {
                            wordsController.currentWord = word
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
