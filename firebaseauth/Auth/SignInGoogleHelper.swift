//
//  SignInGoogleHelper.swift
//  firebaseauth
//
//  Created by Chanuth Kausilu on 2026-01-11.
//
/*
 If needed in another project, see:
 https://github.com/SwiftfulThinking/SwiftfulFirebaseAuth/blob/main/Sources/SwiftfulFirebaseAuth/Helpers/SignInWithGoogle.swift
 */

import Foundation
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInModel{
    let idToken: String
    let accessToken: String
    //name and email also can be taken
    let name: String?
    let email: String?
}

@MainActor
final class SignInGoogleHelper{
    
    func signIn() async throws -> GoogleSignInModel {
        guard let presentingVC = Utilities.shared.topViewController() else { throw URLError(.cannotFindHost) }

        let GIDSignInResult = try await GIDSignIn.sharedInstance.signIn(
            withPresenting: presentingVC
        )
        
        guard let idToken: String = GIDSignInResult.user.idToken?.tokenString else { throw URLError(.badServerResponse)}
        let accessToken = GIDSignInResult.user.accessToken.tokenString
        //name and email can be accessed here like this
        let name = GIDSignInResult.user.profile?.name ?? ""
        let email = GIDSignInResult.user.profile?.email ?? ""
        
        //name and email is also passed but not used
        let tokens = GoogleSignInModel(idToken: idToken, accessToken: accessToken, name: name, email: email)
        return tokens
        //this requires the FirebaseAuth for seperation of concers movin it to authManager's signinwitgoogle function
        //let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

    }
}
