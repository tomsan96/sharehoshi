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
    @State var isPresentedAddWishProductView: Bool = false
    let myWishListViewModel = MyWishListViewModel()

    var body: some View {
        ZStack {
            List {
                ForEach(myWishList) { product in
                    WishListRowView(wishProduct: product, delegate: self)
                        .frame(height: 88)
                }
                .onDelete { indexSet in
                    // TODO: indexSetが複数の場合の対応
                    guard let index = indexSet.first else { return }
                    let ids: [String?] = [myWishList[index].id]
                    Task {
                        do {
                            _ = try await self.myWishListViewModel.deleteMyWishList(uid: self.authenticationViewModel.uid ?? "", ids: ids)
                            myWishList = try await getMyWishList()
                        }
                    }
                }
            }
            .task {
                Task {
                    do {
                        myWishList = try await getMyWishList()
                    }
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        print("add")
                        isPresentedAddWishProductView = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 64, height: 64)
                    .background(Color.blue)
                    .cornerRadius(32)
                    .shadow(color: .gray, radius: 2, x: 2, y: 2)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 24))
                    .sheet(isPresented: $isPresentedAddWishProductView) { () -> AddWishListView in
                        var view = AddWishListView()
                        view.delegate = self
                        return view
                    }
                }
            }
        }
    }

    private func getMyWishList() async throws -> [WishProduct] {
        myWishList = try await self.myWishListViewModel.getMyWishList(uid: self.authenticationViewModel.uid ?? "")
        return myWishList
    }
}

extension MyWishListView: AddWishListViewDelegate {
    func handleAddWishListViewDismiss() async throws {
        myWishList = try await getMyWishList()
    }
}

extension MyWishListView: WishListRowViewDelegate {
    func handleReloadParentView() async throws {
        myWishList = try await getMyWishList()
    }
}

struct MyWishList_Previews: PreviewProvider {
    static var previews: some View {
        MyWishListView()
    }
}
