//
//  saved_word_list_item_view.swift
//  leek
//
//  Created by Daniel Toby on 3/13/22.
//

import SwiftUI


struct SavedWordListItemView: View {
    let word: Word
    let onSaveFunction: () -> Void
    let onUnsaveFunction: () -> Void
    
    var body: some View {
        VStack {
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
            .foregroundColor(.black)
    }
}
