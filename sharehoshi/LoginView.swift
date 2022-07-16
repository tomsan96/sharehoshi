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
        GoogleSignInButton()
            .onTapGesture {
                viewModel.signIn()
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
