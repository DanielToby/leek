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
            SavedWordListView(wordsController: wordsController)
                .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Define...")
                .onSubmit(of: .search) {
                    wordsController.define(searchQuery)
                    isSearchSubmitted = true
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Leek").font(Font.custom("CarterOne", size: 32))
                    }
                }
                .sheet(isPresented: $isSearchSubmitted) {
                    NavigationView {
                        WordView(word: wordsController.currentWord,
                                 onSaveFunction: { wordsController.saveCurrentWord() },
                                 onUnsaveFunction: { wordsController.unsaveCurrentWord() })
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
