//
//  NetworkError.swift
//  TestTask
//
//  Created by Daniil Chemaev on 28.08.2023.
//

import Foundation

// Enum defining various network-related errors that can occur during network operations.
enum NetworkError: Error {
    case invalidURL             // Invalid URL error.
    case noData                 // No data received error.
    case decodingFailed         // Decoding data failed error.
    case serverError(statusCode: Int) // Server error with a specific status code.
    case requestFailed(Error)   // Request failed error.

    // Computed property that provides a localized description for each error case.
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

