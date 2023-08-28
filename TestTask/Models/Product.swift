//
//  Product.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import Foundation

struct Advertisement: Hashable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageURL: String
    let createdDate: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case createdDate = "create_date"
    }
}
