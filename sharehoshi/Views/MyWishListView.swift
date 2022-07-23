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
    @State private var myWishList: [WishProduct] = []
    let myWishListViewModel = MyWishListViewModel()

    var body: some View {
        List(myWishList) { product in
            WishListRowView(wishProduct: product)
                .frame(height: 88)
        }
        .task {
            Task {
                do {
                    myWishList = try await self.myWishListViewModel.getMyWishList(uid: self.authenticationViewModel.uid ?? "")
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
