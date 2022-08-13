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
import FirebaseFirestore
import FirebaseFirestoreSwift

class AuthenticationViewModel: ObservableObject {
    enum SignInState {
        case signedIn
        case signedOut
    }

    @Published var state: SignInState = .signedOut
    @Published var uid: String?

    init() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
                guard let self = self else { return }
                Task {
                    do {
                        _ = await self.authenticateUser(user: user, error: error)
                    }
                }
            }
        }
    }

    func signIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: ((UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController)!) { [weak self] user, error in
            guard let self = self else { return }
            Task {
                do {
                    _ = await self.authenticateUser(user: user, error: error)
                }
            }
        }
    }

    private func authenticateUser(user: GIDGoogleUser?, error: Error?) async {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let authentication = user?.authentication,
              let idToken = authentication.idToken else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        do {
            let result = try await Auth.auth().signIn(with: credential)
            DispatchQueue.main.async {
                self.state = .signedIn
                self.uid = result.user.uid
            }

            let database = Firestore.firestore()
            let usersReference = database.collection("users")
            let userDocument = try await usersReference.document(result.user.uid).getDocument()
            let userInforamation = User(
                displayId: result.user.uid,
                displayName: ""
            )
            if !userDocument.exists {
                try usersReference.document(result.user.uid).setData(from: userInforamation)
            }
        } catch {
            print("error: \(error.localizedDescription)")
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

    func deleteAccount() async throws {
        let user = Auth.auth().currentUser
        guard let user = user else { return }

        // NOTE: アカウント削除
        let database = Firestore.firestore()
        let usersReference = database.collection("users")
        _ = try await user.delete()

        // NOTE: DB削除
        let querySnapshot = try await usersReference.document(user.uid).collection("wishList").getDocuments()
        for document in querySnapshot.documents {
            _ = try await document.reference.delete()
        }
        _ = try await usersReference.document(user.uid).delete()

        DispatchQueue.main.async {
            self.signOut()
        }
    }

}
