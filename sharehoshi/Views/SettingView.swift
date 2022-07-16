//
//  SettingView.swift
//  sharehoshi
//
//  2022/07/16.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var body: some View {
        VStack {
            Text("設定")
            Button("ログアウト") {
                viewModel.signOut()
            }
        }
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
