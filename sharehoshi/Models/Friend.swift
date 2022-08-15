//
//  Friend.swift
//  sharehoshi
//
//  2022/08/14.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Friend: Codable, Identifiable {
    @DocumentID var id: String?
    let displayId: String
    let displayName: String
}
