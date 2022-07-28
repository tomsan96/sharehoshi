//
//  WishProduct.swift
//  sharehoshi
//
//  Created by 山崎定知 on 2022/07/19.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct WishProduct: Codable {
    let name: String
    let imageUrl: String
    let webUrl: String
    let amount: Int?
    let createdAt: Date

    init(name: String, imageUrl: String, webUrl: String, amount: Int?, createdAt: Date) {
        self.name = name
        self.imageUrl = imageUrl
        self.webUrl = webUrl
        if let amount = amount {
            self.amount = amount
        } else {
            self.amount = -1
        }
        self.createdAt = createdAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        webUrl = try container.decode(String.self, forKey: .webUrl)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        let nonOptionalAmount = try container.decode(Int.self, forKey: .amount)
        if nonOptionalAmount < 0 {
            amount = nil
        } else {
            amount = nonOptionalAmount
        }
        let createdAtTimeStamp = try container.decode(Timestamp.self, forKey: .createdAt)
        createdAt = createdAtTimeStamp.dateValue()
    }
}
