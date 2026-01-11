//
//  AuthView.swift
//  firebaseauth
//
//  Created by Chanuth Kausilu on 2026-01-05.
//

import SwiftUI
import Observation
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct GoogleSignInModel{
    let idToken: String
    let accessToken: String
}


@Observable
@MainActor
final class AuthViewModel{
    
    func signInGoogle() async throws {
        
        guard let presentingVC = Utilities.shared.topViewController() else { throw URLError(.cannotFindHost) }

        let GIDSignInResult = try await GIDSignIn.sharedInstance.signIn(
            withPresenting: presentingVC
        )
        
        guard let idToken: String = GIDSignInResult.user.idToken?.tokenString else { throw URLError(.badServerResponse)}
        let accessToken = GIDSignInResult.user.accessToken.tokenString
        
        let tokens = GoogleSignInModel(idToken: idToken, accessToken: accessToken)
        try await AuthManage.shared.signInWithGoogle(tokens: tokens)
        
//this requires the FirebaseAuth for seperation of concers movin it to authManager's signinwitgoogle function
//        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

    }
    
}

struct AuthView: View {
    
    @State private var vm = AuthViewModel()
    @Binding var showSignedInView: Bool
    
    var body: some View {
        VStack{
            
            NavigationLink{
                SigninEmail(showSignedInView: $showSignedInView)
            } label: {
                Text("Sign in with email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height:55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                
            }
            
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .pressed)){
                Task{
                    do{
                        try await vm.signInGoogle()
                        showSignedInView = false
                    }catch{
                        print(error)
                    }
                }
            }
            Spacer()
            
        }
        .padding()
        .navigationTitle("Sign in")
    }
}

#Preview {
    NavigationStack{
        AuthView(showSignedInView: .constant(false))
    }
    
}
