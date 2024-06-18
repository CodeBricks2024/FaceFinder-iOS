//
//  CompareResponse.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/28/24.
//

import Foundation

struct CompareResponse: Decodable {
    let closest_match: String
    let closest_match_img: String
    let distance: Double
    let emotion: String
//    let age: Int
//    let race: String
//    let confidence: Double
    let distances: [Match]
    
    private enum Codingkeys: String, CodingKey {
        case closest_match, closest_match_img, distance, distances, emotion//, race, confidence
//        case age = "predicted_age"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        closest_match = try container.decode(String.self, forKey: .closest_match)
        closest_match_img = try container.decode(String.self, forKey: .closest_match_img)
        distance = try container.decode(Double.self, forKey: .distance)
        emotion = try container.decode(String.self, forKey: .emotion)
//        race = try container.decode(String.self, forKey: .race)
//        confidence = try container.decode(Double.self, forKey: .confidence)
//        age = try container.decode(Int.self, forKey: .age)
        distances = try container.decode([Match].self, forKey: .distances)
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

struct Match: Decodable {
    let image: String
    let name: String
    let distance: Double
    
    private enum Codingkeys: String, CodingKey {
        case image, name, distance
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        image = try container.decode(String.self, forKey: .image)
        name = try container.decode(String.self, forKey: .name)
        distance = try container.decode(Double.self, forKey: .distance)
    }
}
