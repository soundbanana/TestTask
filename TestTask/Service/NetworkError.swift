//
//  NetworkError.swift
//  TestTask
//
//  Created by Daniil Chemaev on 28.08.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingFailed
    case serverError(statusCode: Int)
    case requestFailed(Error)

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingFailed:
            return "Decoding failed"
        case .serverError(let statusCode):
            return "Server error with status code \(statusCode)"
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        }
    }
}
