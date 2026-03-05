//
//  Tag.swift
//  iOS-Test-App
//
//  Created by Lazar Stojkovic on 3/4/26.
//

import Foundation

struct Tag: Codable {
    let name: String
    let commit: Commit
}

struct Commit: Codable {
    let sha: String
}
