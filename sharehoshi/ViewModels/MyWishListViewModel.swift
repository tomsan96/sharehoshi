//
//  MyWishListViewModel.swift
//  sharehoshi
//  2022/07/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class MyWishListViewModel: ObservableObject {
    let database = Firestore.firestore()

    func getMyWishList(uid: String) async throws -> [WishProduct] {
        let usersReference = database.collection("users")
        let querySnapshot = try await usersReference.document(uid).collection("wishList").getDocuments()
        var myWishList: [WishProduct] = []
        if !querySnapshot.isEmpty {
            for document in querySnapshot.documents {
                guard let wishProduct = try? Firestore.Decoder().decode(WishProduct.self, from: document.data()) else { return [] }
                myWishList.append(wishProduct)
            }
        } else {
            print("myWishList is empty")
        }
        return myWishList
    }
}
