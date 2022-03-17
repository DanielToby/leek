//
//  content_view.swift
//  leek
//
//  Created by Daniel Toby on 2/20/22.
//

import SwiftUI

struct ContentView: View {
    @State var searchQuery = ""
    @State var isSheetVisible = false
    @ObservedObject var wordsController = WordsController()
    
    var body: some View {
        NavigationView {
            VStack() {
                WordOfTheDayView(word: wordsController.wordOfTheDay, onToggleSave: wordsController.toggleWordOfTheDayIsSaved)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        wordsController.currentWord = wordsController.wordOfTheDay
                        isSheetVisible = true
                    }
                    .frame(maxHeight: 80)
                    .padding(30)
                    .onReceive(NotificationCenter.default.publisher(
                        for: UIApplication.significantTimeChangeNotification)) { _ in
                            print("A significant amount of time has passed. Recalculating word of the day.")
                            wordsController.calculateWordOfTheDay()
                    }
                Spacer()
                SavedWordListView(wordsController: wordsController, isSheetVisible: $isSheetVisible)
                    .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Define...")
                    .onSubmit(of: .search) {
                        let cleanedQuery = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
                        wordsController.lookup(cleanedQuery)
                        isSheetVisible = true
                    }
            }
            .sheet(isPresented: $isSheetVisible) {
                // Visible only when words are selected or searched.
                NavigationView {
                    WordView(word: wordsController.currentWord, onToggleSave: wordsController.toggleCurrentWordIsSaved)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Leek").font(Font.custom("CarterOne", size: 32))
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
