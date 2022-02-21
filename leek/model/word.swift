//
//  word.swift
//  leek
//
//  Created by Daniel Toby on 2/20/22.
//

struct Word: Identifiable {
    let name: String
    let phoneticSpelling: String
    let definitions: Array<String>
    let id: Int
    var isExpanded = false
}

