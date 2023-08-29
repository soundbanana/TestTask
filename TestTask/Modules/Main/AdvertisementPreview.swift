//
//  AdvertisementPreview.swift
//  TestTask
//
//  Created by Daniil Chemaev on 28.08.2023.
//

import Foundation

struct AdvertisementPreview: Codable {
    let id, title, price, location: String
    let imageURL: String
    let createdDate: String

    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}
