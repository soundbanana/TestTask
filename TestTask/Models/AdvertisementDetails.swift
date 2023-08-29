//
//  AdvertisementDetails.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import Foundation

struct AdvertisementDetails: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageURL: String
    let createdDate: String
    let description: String
    let email: String
    let phoneNumber: String
    let address: String

    enum CodingKeys: String, CodingKey {
        case id, title, price, location, description, email, address
        case imageURL = "image_url"
        case createdDate = "created_date"
        case phoneNumber = "phone_number"
    }
}
