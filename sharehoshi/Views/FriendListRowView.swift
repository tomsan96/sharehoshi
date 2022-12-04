//
//  FriendListRowView.swift
//  sharehoshi
//
//  2022/08/15.
//

import SwiftUI

struct FriendListRowView: View {
    var friend: Friend
    var body: some View {
        HStack {
            Image("")
                .frame(width: 56, height: 56)
                .background(Color.gray)
            VStack(alignment: .leading) {
                Text(friend.displayName)
                Spacer()
                Text(friend.displayId)
                    .font(.caption)
            }
            .padding(.vertical, 16)
        }
    }
}

struct FriendListRowView_Previews: PreviewProvider {
    static var previews: some View {
        FriendListRowView(friend: Friend(displayId: "aaa", displayName: "aaa"))
    }
}
