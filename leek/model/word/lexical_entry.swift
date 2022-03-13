//
//  lexical_entry.swift
//  leek
//
//  Created by Daniel Toby on 3/11/22.
//

import Foundation

struct LexicalEntry: Codable {
    public var entries: Array<WordEntry>
    public var language: String
    public var lexicalCategory: LexicalCategory
    public var text: String
}
