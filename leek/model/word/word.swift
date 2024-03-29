//
//  word.swift
//  leek
//
//  Created by Daniel Toby on 2/20/22.
//
import Foundation

struct Word: Codable {
    public var id: String
    public var data: WordData?
    public var isSaved: Bool
}

extension Word: Identifiable {}
