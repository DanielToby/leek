//
//  content_view.swift
//  leek
//
//  Created by Daniel Toby on 2/20/22.
//

import SwiftUI

struct ContentView: View {
    @State var searchQuery = ""
    @ObservedObject var wordList = WordList()
    
    var body: some View {
        NavigationView {
            WordListView(searchQuery: $searchQuery, wordList: wordList)
        }
        .searchable(text: $searchQuery,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Define...")
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
