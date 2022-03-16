//
//  word_of_the_day_view.swift
//  leek
//
//  Created by Daniel Toby on 3/15/22.
//

import SwiftUI

struct WordOfTheDayView: View {
    let word: Word?
    let onToggleSave: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("The word of the day is...")
                .font(Font.custom("CarterOne", size: 16))
                .foregroundColor(.gray)
            if let word = word {
                HStack {
                    Text(word.id)
                        .font(.system(size: DrawingConstants.listItemTextSize))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    
                    ZStack {
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
        }
    }
}
