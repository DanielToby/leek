//
//  sense.swift
//  leek
//
//  Created by Daniel Toby on 2/26/22.
//

import Foundation

struct WordData: Codable {
    public var id: String
    public var language: String
    public var lexicalEntries: Array<LexicalEntry>
    public var type: String
    public var word: String
}
