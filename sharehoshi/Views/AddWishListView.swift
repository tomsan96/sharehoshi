//
//  AddWishListView.swift
//  sharehoshi
//
//  2022/07/23.
//

import SwiftUI

struct AddWishListView: View {
    @State var webUrl: String = ""
    @State var name: String = ""
    @State var amount: Int?
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    let addWishListViewModel = AddWishListViewModel()
    var body: some View {
        NavigationView {
            VStack {
                TextField("URL", text: $webUrl)
                    .frame(height: 40)
                Divider()
                TextField("商品名", text: $name)
                    .frame(height: 40)
                Divider()
                TextField("金額", value: $amount, formatter: NumberFormatter())
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
                                try await addWishListViewModel.addWishProduct(
                                    uid: authenticationViewModel.uid ?? "",
                                    product: WishProduct(id: "5", name: name, imageUrl: nil, webUrl: nil, amount: amount, createdAt: Date())
                                )
                                dismiss()
                            }
                        }
                    } label: {
                        Text("保存")
                    }
                }
            }
            .navigationTitle("欲しいもの追加")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddWishProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddWishListView()
    }
}