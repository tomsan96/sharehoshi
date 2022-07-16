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
    var body: some View {
        GoogleSignInButton()
    }
}

struct GoogleSignInButton: UIViewRepresentable {
    // TODO: ログイン後の処理
    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.addAction(.init(handler: { _ in
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }

            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.signIn(with: config, presenting: ((UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController)!) { user, error in
                  if let error = error {
                    print(error.localizedDescription)
                    return
                  }
                  guard
                    let authentication = user?.authentication,
                    let idToken = authentication.idToken
                  else {
                    return
                  }
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                    accessToken: authentication.accessToken)
                    Auth.auth().signIn(with: credential) { (authResult, error) in
                        if let error = error {
                            print("error: \(error.localizedDescription)")
                        } else {
                            print(authResult ?? "no authResult")
                        }
                    }
                }
        }), for: .touchUpInside)
        return button
    }
    func updateUIView(_ uiView: GIDSignInButton, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
