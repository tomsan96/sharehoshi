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
        ZStack {
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
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        print("add")
                    } label: {
                        Image(systemName: "plus")
                    }
                    .foregroundColor(Color.white)
                    .frame(width: 64, height: 64)
                    .background(Color.blue)
                    .cornerRadius(32)
                    .shadow(color: .gray, radius: 2, x: 2, y: 2)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 24))
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
