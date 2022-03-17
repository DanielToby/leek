//
//  saved_word_list_item_view.swift
//  leek
//
//  Created by Daniel Toby on 3/13/22.
//

import SwiftUI


struct SavedWordListItemView: View {
    let word: Word
    let onToggleSave: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text(word.id)
                    .font(.system(size: DrawingConstants.listItemTextSize))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                if word.isSaved {
                    Image(systemName: "bookmark.fill").onTapGesture {
                        onToggleSave()
                    }.foregroundColor(DrawingConstants.accentColor)
                } else {
                    Image(systemName: "bookmark").onTapGesture {
                        onToggleSave()
                    }.foregroundColor(DrawingConstants.accentColor)
                }
            }
        }
    }
}
