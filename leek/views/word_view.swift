//
//  word_view.swift
//  leek
//
//  Created by Daniel Toby on 2/19/22.
//

import SwiftUI


struct WordView: View {
    let word: Word?
    let onSaveFunction: () -> Void
    let onUnsaveFunction: () -> Void
    
    var body: some View {
        if let word = word {
            NavigationView {
                if let data = word.data {
                    ScrollView {
                        ForEach(data.lexicalEntries, id: \.lexicalCategory.id) { lexicalEntry in
                            Section(header: Text(lexicalEntry.lexicalCategory.text).fontWeight(.bold)) {
                                ForEach(lexicalEntry.entries, id: \.homographNumber) { entry in
                                    ForEach(entry.senses ?? [], id: \.id) { sense in
                                        ForEach(sense.definitions, id: \.self) { definition in
                                            Text(definition)
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                } else {
                    Text("Word definition not found.")
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text(word.word)
                            .font(.system(size: DrawingConstants.nameTextSize))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        if word.isSaved {
                            Image(systemName: "bookmark.fill").onTapGesture {
                                onUnsaveFunction()
                            }
                        } else {
                            Image(systemName: "bookmark").onTapGesture {
                                onSaveFunction()
                            }
                        }
                    }
                }
            }
        }
    }
}

