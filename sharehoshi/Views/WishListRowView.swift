//
//  WishListRowView.swift
//  sharehoshi
//
//  2022/07/20.
//

import SwiftUI

struct WishListRowView: View {
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
                    if let amount = wishProduct.amount {
                        Text("\(String(amount))円")
                            .font(.caption)
                    } else {
                        Text("")
                            .font(.caption)
                    }
                }
            }
            .padding(.vertical, 16)
            Spacer()
            Button("編集") {
                // TODO: 編集画面表示
            }
        }
    }
}

struct WishListRowView_Previews: PreviewProvider {
    static var previews: some View {
        WishListRowView(wishProduct: WishProduct(name: "", imageUrl: "", webUrl: "", amount: 1, createdAt: Date()))
            .previewLayout(.fixed(width: 500.0, height: 88.0))
            .padding()
    }
}
