//
//  NetworkService.swift
//  TestTask
//
//  Created by Daniil Chemaev on 28.08.2023.
//

import Foundation

protocol AdvertisementsServiceProtocol {
    func fetchAdvertisements(completion: @escaping (Result<AdvertisementResponse, NetworkError>) -> Void)
}

final class AdvertisementsService: AdvertisementsServiceProtocol {
    private let baseURL = "https://www.avito.st/s/interns-ios"

    func fetchAdvertisements(completion: @escaping (Result<AdvertisementResponse, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/main-page.json") else {
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
                let result = try JSONDecoder().decode(AdvertisementResponse.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }

        task.resume()
    }

}
