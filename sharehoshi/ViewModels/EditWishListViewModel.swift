//
//  EditWishListViewModel.swift
//  sharehoshi
//
//  2022/08/03.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class EditWishListViewModel {
    let database = Firestore.firestore()
    func editWishProduct(uid: String, product: WishProduct, editData: [String: Any]) async throws {
        guard let id = product.id else { return }
        let usersReference = database.collection("users")
        var addTimeStampEditData = editData
        addTimeStampEditData["updatedAt"] = FieldValue.serverTimestamp()
        _ = try await usersReference.document(uid).collection("wishList").document(id).updateData(addTimeStampEditData)
    }
}
