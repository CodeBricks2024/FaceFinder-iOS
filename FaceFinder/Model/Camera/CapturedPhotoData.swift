//
//  CapturedPhotoData.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/11/24.
//

import Foundation

struct CapturedPhotoData: Codable {
    var filePath: String
    
    private enum Codingkeys: String, CodingKey {
        case filePath
    }
    
    init(filePath: String) {
        self.filePath = filePath
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        filePath = try container.decode(String.self, forKey: .filePath)
    }
}
