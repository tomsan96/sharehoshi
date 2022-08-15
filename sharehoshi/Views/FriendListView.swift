//
//  FriendListView.swift
//  sharehoshi
//
//  2022/08/15.
//

import SwiftUI

struct FriendListView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    private var friendList: [Friend] = []

    // TODO: DB繋ぎ込み
    init() {
        friendList = [
            Friend(id: "1", displayId: "taro_yamada", displayName: "山田"),
            Friend(id: "2", displayId: "taro", displayName: "太郎"),
            Friend(id: "3", displayId: "abcd", displayName: "花子"),
            Friend(id: "4", displayId: "abc", displayName: "Tom"),
            Friend(id: "5", displayId: "aaa-aaaa", displayName: "さとう"),
            Friend(id: "6", displayId: "ichiro", displayName: "イチロー"),
            Friend(id: "7", displayId: "taro_yamada", displayName: "")
        ]
    }
    var body: some View {
        List {
            ForEach(friendList) { friend in
                FriendListRowView(friend: friend)
            }
        }
    }
}

struct FriendListView_Previews: PreviewProvider {
    static var previews: some View {
        FriendListView()
    }
}
