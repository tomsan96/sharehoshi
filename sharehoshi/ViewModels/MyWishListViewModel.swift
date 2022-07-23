//
//  MyWishListViewModel.swift
//  sharehoshi
//  2022/07/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class MyWishListViewModel {
    let database = Firestore.firestore()

    func getMyWishList(uid: String) async throws -> [WishProduct] {
        let usersReference = database.collection("users")
        var wishList: [WishProduct] = []
        let querySnapshot = try await usersReference.document(uid).collection("wishList").getDocuments()

        if !querySnapshot.isEmpty {
            for document in querySnapshot.documents {
                guard let wishProduct = try? Firestore.Decoder().decode(WishProduct.self, from: document.data()) else { return [] }
                wishList.append(wishProduct)
                print(wishList)
            }
        } else {
            print("Document does not exist")
        }
        return wishList
    }
}
