//
//  Extensions+String.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/28/24.
//

import Foundation

extension String {
    
    var jsonStringToDictionary: [String: AnyObject]? {
        if let data = data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] } catch let error as NSError {
                    print(error)
                }
        }
        return nil
    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func toInt() -> Int? {
        return NumberFormatter().number(from: self)?.intValue
    }
    
    func toEmoji() -> String {
        print("emoji self: \(self)")
        switch self {
            case "happy":
                return Appearance.Emoji.happy
            case "neutral":
                return Appearance.Emoji.neutral
            case "fear":
                return Appearance.Emoji.fear
            case "disgust":
                return Appearance.Emoji.disgust
            case "angry":
                return Appearance.Emoji.angry
            case "sad":
                return Appearance.Emoji.sad
            case "surprise":
                return Appearance.Emoji.surprise
            default:
                return Appearance.Emoji.neutral
        }
    }
}
