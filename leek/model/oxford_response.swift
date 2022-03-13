//
//  oxford_response.swift
//  leek
//
//  Created by Daniel Toby on 2/21/22.
//

// The following structs mirror the model of the Oxford dictionary API (v2)

struct OxfordResponseMetadata: Codable {
    let operation: String
    let provider: String
    let schema: String
}

struct OxfordResponse: Codable {
    let id: String
    let metadata: OxfordResponseMetadata
    let results: Array<WordData>
    let word: String
}

