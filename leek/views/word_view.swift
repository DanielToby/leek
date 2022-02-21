//
//  word_view.swift
//  leek
//
//  Created by Daniel Toby on 2/19/22.
//

import SwiftUI


struct WordView: View {
    let word: Word
    
    var body: some View {
            VStack {
                HStack {
                    VStack {
                        Text(word.name)
                            .font(.system(size: DrawingConstants.nameTextSize))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        Text(word.phoneticSpelling)
                            .font(.system(size: DrawingConstants.definitionTextSize))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    }.padding(10)
                    Image(uiImage: UIImage(named: "AppIcon")!)
                        .resizable()
                        .frame(width: DrawingConstants.iconSize, height: DrawingConstants.iconSize)
                        .rotationEffect(.degrees(word.isExpanded ? 0 : Double.random(in: 20..<30) * (Bool.random() ? 1 : -1)))
                }
            }.padding(5)
    }

    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 5
        static let nameTextSize: CGFloat = 24
        static let definitionTextSize: CGFloat = 16
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
        static let iconSize: CGFloat = 32
    }
}
