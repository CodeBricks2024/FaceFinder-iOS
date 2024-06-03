//
//  FFError.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/28/24.
//

import Foundation

enum FaceFinder {
    
    public enum NetworkError: Error {
        
        typealias CustomError = FaceFinder.NetworkError
        
        // MARK: - Database Error -
        case ERR_DB_NO_DATA
        
        // MARK: - Send File Error -
        case ERR_SEND_FILE_FAILED
        
        init?(statusCode: Int, message: String?) {
            switch statusCode {
            case 3000:
                self = .ERR_DB_NO_DATA
            case 2000:
                self = .ERR_SEND_FILE_FAILED
            default:
                self = .ERR_DB_NO_DATA
            }
        }
    }    
}

