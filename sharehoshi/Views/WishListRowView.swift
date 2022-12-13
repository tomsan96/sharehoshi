//
//  WishListRowView.swift
//  sharehoshi
//
//  2022/07/20.
//

import SwiftUI

struct WishListRowView: View {
    @State var isPresentedEditWishProductView: Bool = false
    var wishProduct: WishProduct
    let delegate: WishListRowViewDelegate
    var body: some View {
        HStack {
            Image("")
                .frame(width: 56, height: 56)
                .background(Color.gray)
            VStack(alignment: .leading) {
                Text(wishProduct.name)
                Spacer()
                Group {
                    if wishProduct.amount < 0 {
                        Text("")
                            .font(.caption)
                    } else {
                        Text("\(String(wishProduct.amount))円")
                            .font(.caption)
                    }
                }
            }
            .padding(.vertical, 16)
            Spacer()
            if let webUrl = URL(string: wishProduct.webUrl) {
                Link("", destination: webUrl)
            }
            Text("編集")
                .onTapGesture {
                    isPresentedEditWishProductView = true
                }
            .sheet(isPresented: $isPresentedEditWishProductView) { () -> EditWishListView in
                var view = EditWishListView(product: wishProduct)
                view.delegate = self
                return view
            }
        }
    }
}

extension WishListRowView: EditWishListViewDelegate {
    func handleAddWishListViewDismiss() async throws {
        try await delegate.handleReloadParentView()
    }
}
