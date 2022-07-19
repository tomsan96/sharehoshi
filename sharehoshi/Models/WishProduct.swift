//
//  WishProduct.swift
//  sharehoshi
//
//  Created by 山崎定知 on 2022/07/19.
//

import Foundation

struct WishProduct: Codable {
    let id: String
    let name: String?
    let imageUrl: URL?
    let webUrl: URL?
    let amount: Int?
    let createdAt: Date
}
