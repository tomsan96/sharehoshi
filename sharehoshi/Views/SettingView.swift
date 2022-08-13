//
//  SettingView.swift
//  sharehoshi
//
//  2022/07/16.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State private var isPresentedDeleteAccountAlert = false
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: TermsView()) {
                    Text("利用規約")
                }
                Button("アカウント削除") {
                    self.isPresentedDeleteAccountAlert = true
                }
                .alert("アカウント情報を削除しますか？", isPresented: $isPresentedDeleteAccountAlert) {
                    Button("削除", role: .destructive) {
                        Task {
                            do {
                                _ = try await viewModel.deleteAccount()
                            }
                        }
                    }
                } message: {
                    Text("アカウント情報を完全に削除しますか？この操作は取り消せません")
                }
                Button("ログアウト") {
                    viewModel.signOut()
                }
            }
        }
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
