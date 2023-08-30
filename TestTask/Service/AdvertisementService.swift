//
//  AdvertisementService.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import Foundation

protocol AdvertisementServiceProtocol {
    func fetchAdvertisement(advertisementID: String, completion: @escaping (Result<AdvertisementDetails, NetworkError>) -> Void)
}

final class AdvertisementService: AdvertisementServiceProtocol {
    private let baseURL = "https://www.avito.st/s/interns-ios"

    func fetchAdvertisement(advertisementID: String, completion: @escaping (Result<AdvertisementDetails, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/details/\(advertisementID).json") else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.serverError(statusCode: 0)))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let result = try JSONDecoder().decode(AdvertisementDetails.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }

        task.resume()
    }

}
