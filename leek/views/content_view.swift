//
//  content_view.swift
//  leek
//
//  Created by Daniel Toby on 2/20/22.
//

import SwiftUI

struct ContentView: View {
    @State var searchQuery = ""
    @State var isSearchSubmitted = false
    @ObservedObject var wordsController = WordsController()
    
    var body: some View {
        NavigationView {
            ZStack {
                SavedWordListView(wordsController: wordsController)
                    .searchable(text: $searchQuery, prompt: "Define...")
                    .onSubmit(of: .search) {
                        wordsController.define(searchQuery)
                        isSearchSubmitted = true
                    }
                if (wordsController.currentWord != nil) {
                    NavigationLink(destination: WordView(word: wordsController.currentWord,
                                                         onSaveFunction: { wordsController.saveCurrentWord() },
                                                         onUnsaveFunction: { wordsController.unsaveCurrentWord() }
                                                        ),
                                   isActive: $isSearchSubmitted) {
                        EmptyView()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 12 Pro")
            
            //            ContentView()
            //                .previewDevice("iPad Pro (9.7-inch)")
        }
    }
}
