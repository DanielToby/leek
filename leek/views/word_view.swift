//
//  word_view.swift
//  leek
//
//  Created by Daniel Toby on 2/19/22.
//

import SwiftUI


struct WordView: View {
    let word: Word?
    let onToggleSave: () -> Void
    
    var body: some View {
        if let word = word {
            if let data = word.data {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(data.lexicalEntries, id: \.lexicalCategory.id) { lexicalEntry in
                            Text("\(lexicalEntry.lexicalCategory.text):").bold()
                                .foregroundColor(.gray)
                            Spacer()
                            ForEach(lexicalEntry.entries, id: \.homographNumber) { entry in
                                if let pronunciations = entry.pronunciations {
                                    VStack {
                                        ForEach(pronunciations.indices) { i in
                                            Text("\(pronunciations[i].phoneticSpelling) (\(pronunciations[i].dialects.joined(separator: ", ")))")
                                                .italic()
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                if let senses = entry.senses {
                                    ForEach(senses.indices) { i in
                                        ForEach(senses[i].definitions, id: \.self) { definition in
                                            HStack {
                                                Text("\(i + 1).")
                                                Text(definition)
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }
                    }.padding(20)
                }
                .frame(maxWidth: .infinity)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text(word.id)
                                .font(Font.custom("CarterOne", size: DrawingConstants.nameTextSize))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            if word.isSaved {
                                Image(systemName: "bookmark.fill").onTapGesture {
                                    onToggleSave()
                                }
                            } else {
                                Image(systemName: "bookmark").onTapGesture {
                                    onToggleSave()
                                }
                            }
                        }.foregroundColor(DrawingConstants.accentColor)
                    }
                }
            } else {
                Text("Word definition not found.")
            }
        }
    }
}

