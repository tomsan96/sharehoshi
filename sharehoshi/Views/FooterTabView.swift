//
//  FooterTabView.swift
//  sharehoshi
//
//  2022/07/16.
//

import SwiftUI

struct FooterTabView: View {
    var body: some View {
        TabView {
            FriendListView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("ともだち")
                }
            MyWishListView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("欲しいもの")
                }
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("設定")
                }
        }
    }
}

struct FooterTabView_Previews: PreviewProvider {
    static var previews: some View {
        FooterTabView()
    }
}
