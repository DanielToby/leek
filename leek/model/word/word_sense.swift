//
//  word_sense.swift
//  leek
//
//  Created by Daniel Toby on 3/11/22.
//

import Foundation

struct WordSense: Codable {
    public var id: String
    public var definitions: Array<String>
    // let examples: Array<Example>
    // public var subsenses: Array<WordSense>?
}
