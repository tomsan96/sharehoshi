//
//  User.swift
//  sharehoshi
//
//  2022/07/18.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id: String?
    let displayId: String
    let displayName: String
    let createdAt: Date
    let updatedAt: Date
}
