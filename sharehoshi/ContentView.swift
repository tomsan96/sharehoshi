//
//  ContentView.swift
//  sharehoshi
//
//  Created by 山崎定知 on 2022/07/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MyWishList()
                .tabItem {
                    Image(systemName: "cart")
                    Text("欲しいもの")
                }
            Setting()
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
