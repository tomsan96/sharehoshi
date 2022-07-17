//
//  AuthenticationViewModel.swift
//  sharehoshi
//
//  2022/07/16.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {
    enum SignInState {
        case signedIn
        case signedOut
    }

    @Published var state: SignInState = .signedOut

    init() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
                guard let self = self else { return }
                self.authenticateUser(user: user, error: error)
            }
        }
    }

    func signIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: ((UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController)!) { [weak self] user, error in
            guard let self = self else { return }
            self.authenticateUser(user: user, error: error)
        }
    }

    private func authenticateUser(user: GIDGoogleUser?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let authentication = user?.authentication,
              let idToken = authentication.idToken else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (_, error) in
            if let error = error {
                print("error: \(error.localizedDescription)")
            } else {
                self.state = .signedIn
            }
        }
    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        do {
            try Auth.auth().signOut()
            state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }
}
