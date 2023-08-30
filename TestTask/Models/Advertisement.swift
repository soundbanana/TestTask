//
//  Advertisement.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import Foundation

// MARK: - Advertisement Struct

struct Advertisement: Codable, Hashable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageURL: String
    let createdDate: String

    // CodingKeys to map JSON keys to struct properties
    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}

// MARK: - AdvertisementResponse Struct

struct AdvertisementResponse: Codable {
    let advertisements: [Advertisement]
}
