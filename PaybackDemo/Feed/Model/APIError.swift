//
//  APIError.swift
//  PaybackDemo
//
//

import Foundation

enum APIError: Error {
    case requestFailed
    case invalidData
    case noData
}

extension APIError: CustomStringConvertible {
    var description: String {
        switch self {
        case .requestFailed:
            return "Something went wrong, Please try again"
        case .invalidData:
            return "Something went wrong, Please try again"
        case .noData:
            return "We dont have any features to show, Please try again"
        }
    }
}
