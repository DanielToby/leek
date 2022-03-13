//
//  word_entry.swift
//  leek
//
//  Created by Daniel Toby on 3/11/22.
//

import Foundation

struct WordEntry: Codable {
    public var homographNumber: String
    public var senses: Array<WordSense>
}
