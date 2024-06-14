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
    let age: Int
    let race: String
    let confidence: Double
//    let gender: Gender
    
    private enum Codingkeys: String, CodingKey {
        case closest_match, distance, emotion, race, confidence//, gender
        case age = "predicted_age"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        closest_match = try container.decode(String.self, forKey: .closest_match)
        distance = try container.decode(Double.self, forKey: .distance)
        emotion = try container.decode(String.self, forKey: .emotion)
        race = try container.decode(String.self, forKey: .race)
        confidence = try container.decode(Double.self, forKey: .confidence)
//        gender = try container.decode(Gender.self, forKey: .gender)
        age = try container.decode(Int.self, forKey: .age)
    }
}

struct Gender: Decodable {
    let woman: Double
    let man: Double
    
    private enum Codingkeys: String, CodingKey {
        case woman, man
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        woman = try container.decode(Double.self, forKey: .woman)
        man = try container.decode(Double.self, forKey: .man)
    }
}
