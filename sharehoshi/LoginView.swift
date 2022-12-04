//
//  LoginView.swift
//  sharehoshi
//
//  2022/07/09.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var body: some View {
        NavigationStack {
            VStack {
                Text("新規登録・ログイン")
                    .font(.title)
                GoogleSignInButton()
                    .onTapGesture {
                        viewModel.signIn()
                    }
                    .frame(width: 240, height: 48)
                Text(
                    """
                    Googleでログインできます。
                    下記利用規約に同意した上でログインしてください。
                    """
                )
                NavigationLink(destination: TermsView()) {
                    Text("利用規約")
                }
            }
        }
    }
}

struct GoogleSignInButton: UIViewRepresentable {
    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        return button
    }
    func updateUIView(_ uiView: GIDSignInButton, context: Context) {}
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
