//
//  CompareResponse.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/28/24.
//

import Foundation

struct CompareResponse: Codable {
    let closest_match: String
    let distance: Double
}
