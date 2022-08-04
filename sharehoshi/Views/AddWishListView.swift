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
    @State var amount: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    var delegate: AddWishListViewDelegate?
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
                                try await addWishListViewModel.addWishProduct(
                                    uid: authenticationViewModel.uid ?? "",
                                    product: WishProduct(name: name, imageUrl: "", webUrl: "", amount: Int(amount), createdAt: Date(), updatedAt: Date())
                                )
                                try await delegate?.handleDismiss()
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
