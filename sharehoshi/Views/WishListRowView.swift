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
            Button {
                isPresentedEditWishProductView = true
            } label: {
                Text("編集")
            }
            .sheet(isPresented: $isPresentedEditWishProductView) {
                EditWishListView(product: wishProduct)
            }

//            Button("編集") {
//                isPresentedEditWishProductView = true
//            }
//            .sheet(isPresented: $isPresentedEditWishProductView) { () -> EditWishListView in
//                let view = EditWishListView(product: wishProduct)
//                return view
//            }
        }
    }
}

struct WishListRowView_Previews: PreviewProvider {
    static var previews: some View {
        WishListRowView(wishProduct: WishProduct(name: "", imageUrl: "", webUrl: "", amount: 1, createdAt: Date(), updatedAt: Date()))
            .previewLayout(.fixed(width: 500.0, height: 88.0))
            .padding()
    }
}
