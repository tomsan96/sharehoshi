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
    @DocumentID var id: String?
    let name: String
    let imageUrl: String
    let webUrl: String
    // NOTE: 金額未設定の場合は-1を格納する
    let amount: Int
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
}
