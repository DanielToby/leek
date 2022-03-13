//
//  word.swift
//  leek
//
//  Created by Daniel Toby on 2/20/22.
//
import Foundation

struct Word {
    public var word: String
    public var data: WordData?
    public var id: Int
    public var isSaved: Bool
}

extension Word: Identifiable {}
