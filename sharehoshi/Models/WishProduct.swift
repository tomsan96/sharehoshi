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
    let imageUrl: URL?
    let webUrl: URL?
    let amount: Int?
    let createdAt: Date

    init(id: String, name: String?, imageUrl: URL?, webUrl: URL?, amount: Int?, createdAt: Date) {
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
        let webUrlString = try container.decode(String.self, forKey: .webUrl)
        if webUrlString.isEmpty {
            webUrl = nil
        } else {
            webUrl = URL(string: webUrlString)
        }
        let imageUrlString = try container.decode(String.self, forKey: .imageUrl)
        if imageUrlString.isEmpty {
            imageUrl = nil
        } else {
            imageUrl = URL(string: imageUrlString)
        }
        amount = try container.decode(Int?.self, forKey: .amount)
        let createdAtTimeStamp = try container.decode(Timestamp.self, forKey: .createdAt)
        createdAt = createdAtTimeStamp.dateValue()
    }
}
