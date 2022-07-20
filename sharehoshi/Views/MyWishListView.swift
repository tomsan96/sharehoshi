//
//  MyWishListView.swift
//  sharehoshi
//
//  2022/07/16.
//

import SwiftUI

struct MyWishListView: View {
    let wishProducts = [
        WishProduct(id: "1", name: "商品a", imageUrl: nil, webUrl: nil, amount: 1000, createdAt: Date()),
        WishProduct(id: "2", name: "商品b", imageUrl: nil, webUrl: nil, amount: 500, createdAt: Date()),
        WishProduct(id: "3", name: "商品c", imageUrl: nil, webUrl: nil, amount: 2300, createdAt: Date()),
        WishProduct(id: "4", name: "商品d", imageUrl: nil, webUrl: nil, amount: 100, createdAt: Date()),
        WishProduct(id: "5", name: "商品e", imageUrl: nil, webUrl: nil, amount: 1100, createdAt: Date()),
        WishProduct(id: "6", name: "商品f", imageUrl: nil, webUrl: nil, amount: 1000000, createdAt: Date())
    ]

    var body: some View {
        List(wishProducts) { product in
            WishListRowView(wishProduct: product)
                .frame(height: 88)
        }
    }
}

struct MyWishList_Previews: PreviewProvider {
    static var previews: some View {
        MyWishListView()
    }
}
