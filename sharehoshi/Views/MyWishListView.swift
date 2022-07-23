//
//  MyWishListView.swift
//  sharehoshi
//
//  2022/07/16.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct MyWishListView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    let myWishListViewModel = MyWishListViewModel()
    var uid: String? {
        get {
            guard let uid = authenticationViewModel.uid else { return nil }
            return uid
        }
    }

    var body: some View {

        List(myWishListViewModel.myWishList) { product in
            WishListRowView(wishProduct: product)
                .frame(height: 88)
        }
        .task {
            Task {
                do {
                    try await self.myWishListViewModel.getMyWishList(uid: "90sZjw9tG8WQesffk0OKIMkG5Lf2")
                }
            }
        }
    }
}

struct MyWishList_Previews: PreviewProvider {
    static var previews: some View {
        MyWishListView()
    }
}
