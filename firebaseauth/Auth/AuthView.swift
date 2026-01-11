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

@Observable
@MainActor
final class AuthViewModel{
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthManage.shared.signInWithGoogle(tokens: tokens)
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
