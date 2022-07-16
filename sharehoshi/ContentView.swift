//
//  ContentView.swift
//  sharehoshi
//
//  2022/07/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
