//
//  WishProduct.swift
//  sharehoshi
//
//  Created by 山崎定知 on 2022/07/19.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct WishProduct: Codable, Identifiable {
    let id: String
    let name: String?
    let imageUrl: String?
    let webUrl: String?
    let amount: Int?
    let createdAt: Date

    init(id: String, name: String?, imageUrl: String?, webUrl: String?, amount: Int?, createdAt: Date) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.webUrl = webUrl
        self.amount = amount
        self.createdAt = createdAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String?.self, forKey: .name)
        webUrl = try container.decode(String?.self, forKey: .webUrl)
        imageUrl = try container.decode(String?.self, forKey: .imageUrl)
        amount = try container.decode(Int?.self, forKey: .amount)
        let createdAtTimeStamp = try container.decode(Timestamp.self, forKey: .createdAt)
        createdAt = createdAtTimeStamp.dateValue()
    }
}
