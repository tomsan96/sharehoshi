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
    @Published var myWishList: [WishProduct] = []

    func getMyWishList(uid: String) async throws {
        let usersReference = database.collection("users")
        let querySnapshot = try await usersReference.document(uid).collection("wishList").getDocuments()

        if !querySnapshot.isEmpty {
            for document in querySnapshot.documents {
                guard let wishProduct = try? Firestore.Decoder().decode(WishProduct.self, from: document.data()) else { return }
                myWishList.append(wishProduct)
                print(myWishList)
            }
        } else {
            print("Document does not exist")
        }
    }
}
