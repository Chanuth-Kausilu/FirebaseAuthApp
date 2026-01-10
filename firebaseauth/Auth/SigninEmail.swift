//
//  SigninEmail.swift
//  firebaseauth
//
//  Created by Chanuth Kausilu on 2026-01-05.
//

import SwiftUI
import Observation

@Observable
@MainActor
final class SignInEmailVeiwModel{
    
    var email = ""
    var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("Email and password is needed")
            return
        }
        
        let returnUserData = try await AuthManage.shared.createUser(email: email, password: password)
        print("Success")
        print(returnUserData)
        
        
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("Email and password is needed")
            return
        }
        
        try await AuthManage.shared.signInUser(email: email, password: password)
        
        
        
    }
    
    
    
}

struct SigninEmail: View {
    
    @State private var viewModel = SignInEmailVeiwModel()
    @Binding var showSignedInView: Bool
    var body: some View {
        VStack{
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(8)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(8)
            
            Button{
                Task{
                    do{
                        try await viewModel.signUp()
                        showSignedInView = false
                        return
                    }catch{
                        print(error)
                    }
                    
                    do{
                        try await viewModel.signIn()
                        showSignedInView = false
                        return
                    }catch{
                        print(error)
                    }
                }
                
            }label: {
                Text("Sign in")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height:55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Sign in with Email")
        Spacer()
    }
}

#Preview {
    SigninEmail(showSignedInView: .constant(false))
}
