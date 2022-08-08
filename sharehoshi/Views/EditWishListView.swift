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
    let previousProduct: WishProduct
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    var delegate: AddWishListViewDelegate?
    let editWishListViewModel = EditWishListViewModel()

    init(product: WishProduct) {
        previousProduct = product
        _webUrl = State(initialValue: product.webUrl)
        _name = State(initialValue: product.name)
        if product.amount < 0 {
            _amount = State(initialValue: "")
        } else {
            _amount = State(initialValue: String(product.amount))
        }
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
                                _ = try await save()
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
    private func save() async throws {
        var editData: [String: Any] = [:]
        if previousProduct.webUrl != webUrl {
            editData["webUrl"] = webUrl
        }
        if previousProduct.name != name {
            editData["name"] = name
        }
        var intAmount: Int
        if amount == "" {
            intAmount = -1
        } else {
            intAmount = Int(amount) ?? -1
        }
        if previousProduct.amount != intAmount {
            editData["amount"] = intAmount
        }
        _ = try await editWishListViewModel.editWishProduct(uid: authenticationViewModel.uid ?? "", product: previousProduct, editData: editData)
    }
}

struct EditWishProductView_Previews: PreviewProvider {
    static var previews: some View {
        EditWishListView(product: WishProduct(name: "", imageUrl: "", webUrl: "", amount: nil, createdAt: Date(), updatedAt: Date()))
    }
}
