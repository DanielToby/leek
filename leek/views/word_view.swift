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
            VStack {
                HStack {
                    VStack {
                        Text(word.word)
                            .font(.system(size: DrawingConstants.nameTextSize))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        if let data = word.data {
                            VStack {
                                ForEach(data.lexicalEntries, id: \.lexicalCategory.id) { lexicalEntry in
                                    Text(lexicalEntry.lexicalCategory.text)
                                    ForEach(lexicalEntry.entries, id: \.homographNumber) { entry in
                                        Text(entry.homographNumber ?? "No homograph number")
                                        ForEach(entry.senses ?? [], id: \.id) { sense in
                                            Text(sense.id)
                                            ForEach(sense.definitions, id: \.self) { definition in
                                                Text(definition)
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            Text("Word definition not found.")
                        }
                    }.padding(10)
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
            }.padding(5)
        } else {
            Text("Fetching definition...")
        }
    }
    
    private struct DrawingConstants {
        static let titleTextSize: CGFloat = 32
        static let accentColor =  Color(red: 116 / 255, green: 156 / 255, blue: 79 / 255)
        static let cornerRadius: CGFloat = 5
        static let nameTextSize: CGFloat = 24
        static let definitionTextSize: CGFloat = 16
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
        static let iconSize: CGFloat = 32
    }
}
