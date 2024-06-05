//
//  CompareResponse.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/28/24.
//

import Foundation

struct CompareResponse: Decodable {
    let closest_match: String
    let distance: Double
    let emotion: String
    let age: String
    let race: String
    let confidence: String
    let gender: Gender
}

struct Gender: Decodable {
    let woman: Double
    let man: Double
}
