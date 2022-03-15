//
//  word_of_the_day_view.swift
//  leek
//
//  Created by Daniel Toby on 3/15/22.
//

import SwiftUI

struct WordOfTheDayView: View {
    let word: Word?
    let onSaveFunction: () -> Void
    let onUnsaveFunction: () -> Void
    
    var body: some View {
        ZStack {
            if let word = word {
                VStack {
                    Text("Word of the day").bold()
                    HStack {
                        Text(word.word)
                            .font(.system(size: DrawingConstants.listItemTextSize))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        if word.isSaved {
                            Image(systemName: "bookmark.fill").onTapGesture {
                                onUnsaveFunction()
                            }.foregroundColor(DrawingConstants.accentColor)
                        } else {
                            Image(systemName: "bookmark").onTapGesture {
                                onSaveFunction()
                            }.foregroundColor(DrawingConstants.accentColor)
                        }
                    }.padding(10)
                }.padding(10)
            } else {
                Text("Word definition not found.")
            }
        }
    }
}
