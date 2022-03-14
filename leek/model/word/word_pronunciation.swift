//
//  word_pronunciation.swift
//  leek
//
//  Created by Daniel Toby on 3/13/22.
//

import Foundation

struct WordPronunciation: Codable {
    public var audioFile: String
    public var dialects: Array<String>
    public var phoneticNotation: String
    public var phoneticSpelling: String
}
