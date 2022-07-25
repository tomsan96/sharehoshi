//
//  AddWishListViewModel.swift
//  sharehoshi
//
//  2022/07/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class AddWishListViewModel {
    let database = Firestore.firestore()
    func addWishProduct(uid: String, product: WishProduct) throws {
        let usersReference = database.collection("users")
        _ = try usersReference.document(uid).collection("wishList").addDocument(from: product)
    }
}
