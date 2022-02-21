//
//  word_list_view.swift
//  leek
//
//  Created by Daniel Toby on 2/18/22.
//

import SwiftUI

struct WordListView: View {
    @Binding var searchQuery: String
    @ObservedObject var wordList: WordList
    
    var body: some View {
        ZStack {
            if (searchQuery.isEmpty) {
                List {
                    ForEach(wordList.savedWords) { word in
                        VStack {
                            WordView(word: word)
                                .onTapGesture {
                                    wordList.expandWord(word)
                                }
                            if (word.isExpanded) {
                                Text("Saved 2/20/22.")
                            }
                        }
                    }
                }
            } else {
                List {
                    ForEach(wordList.searchedWords) { word in
                        VStack {
                            WordView(word: word)
                                .onTapGesture {
                                    wordList.expandWord(word)
                                }
                            if (word.isExpanded) {
                                Button("Save") {
                                    wordList.expandWord(word)
                                }
                            }
                        }
                    }
                }
            }
            if (searchQuery.isEmpty && wordList.savedWords.isEmpty) {
                Text("You haven't saved any words yet.")
            }
        }
        .onChange(of: searchQuery) { _ in
            wordList.searchFor(searchQuery)
        }
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Leek")
                        .font(Font.custom("CarterOne", size: DrawingConstants.titleTextSize))
                        .padding()
                        .foregroundColor( DrawingConstants.accentColor)
                }
            }
        
        
    }
    
    private struct DrawingConstants {
        static let titleTextSize: CGFloat = 32
        static let accentColor =  Color(red: 116 / 255, green: 156 / 255, blue: 79 / 255)
    }
}

struct WordListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
