//
//  EditWishListView.swift
//  sharehoshi
//
//  2022/08/03.
//

import SwiftUI

struct EditWishListView: View {
    @State var webUrl: String
    @State var name: String
    @State var amount: String
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    var delegate: AddWishListViewDelegate?

    init(product: WishProduct) {
        _webUrl = State(initialValue: product.webUrl)
        _name = State(initialValue: product.name)
        _amount = State(initialValue: String(product.amount))
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("URL", text: $webUrl)
                    .frame(height: 40)
                Divider()
                TextField("商品名", text: $name)
                    .frame(height: 40)
                Divider()
                TextField("金額", text: $amount)
                    .frame(height: 40)
                    .keyboardType(.numberPad)
                Divider()
                Spacer()
            }
            .padding(.horizontal, 16)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("キャンセル")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                            do {
                                dismiss()
                            }
                        }
                    } label: {
                        Text("保存")
                    }
                }
            }
            .navigationTitle("欲しいもの編集")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct EditWishProductView_Previews: PreviewProvider {
    static var previews: some View {
        EditWishListView(product: WishProduct(name: "", imageUrl: "", webUrl: "", amount: nil, createdAt: Date(), updatedAt: Date()))
    }
}
