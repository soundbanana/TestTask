//
//  AdvertisementService.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import Foundation

// Protocol defining the interface for fetching advertisement details.
protocol AdvertisementServiceProtocol {
    func fetchAdvertisement(advertisementID: String, completion: @escaping (Result<AdvertisementDetails, NetworkError>) -> Void)
}

// Service class responsible for fetching advertisement details from the server.
final class AdvertisementService: AdvertisementServiceProtocol {
    private let baseURL = "https://www.avito.st/s/interns-ios"

    // Fetches advertisement details from the server.
    func fetchAdvertisement(advertisementID: String, completion: @escaping (Result<AdvertisementDetails, NetworkError>) -> Void) {
        // Construct the URL for fetching advertisement details.
        guard let url = URL(string: "\(baseURL)/details/\(advertisementID).json") else {
            completion(.failure(.invalidURL))
            return
        }

        // Create a URLSession data task to fetch data from the server.
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            // Ensure a valid HTTP response.
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.serverError(statusCode: 0)))
                return
            }

            // Check if the response status code indicates success.
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }

            // Ensure data is present in the response.
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            // Attempt to decode the fetched data.
            do {
                let result = try JSONDecoder().decode(AdvertisementDetails.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }

        // Start the URLSession data task.
        task.resume()
    }
}
