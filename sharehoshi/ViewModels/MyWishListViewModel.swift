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

    func getMyWishList(uid: String) {
        let usersReference = database.collection("users")
        let wishList: [WishProduct] = []
        usersReference.document(uid).collection("wishList").getDocuments() {(querySnapshot, error ) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
//                    wishList.append(document.data())
                }
                return
            }
        }

    }
}
