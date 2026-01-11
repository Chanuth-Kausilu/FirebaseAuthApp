//
//  SettingsView.swift
//  firebaseauth
//
//  Created by Chanuth Kausilu on 2026-01-09.
//

import SwiftUI
import Observation

@Observable
@MainActor
final class SettingsViewModel {
    
    
    var authProviders: [AuthProviderOptions] = []
    
    func fetchAuthProviders() {
        if let providers = try? AuthManage.shared.getProviders(){
            authProviders=providers
        }
    }
    
    func signOut() throws {
        try AuthManage.shared.signOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthManage.shared.getAuthenticatedUser()
        
        guard let userEmail = authUser.email else {
            throw URLError(.unknown)
        }
        
        try await AuthManage.shared.resetPassword(email: userEmail)
    }
    
    func updatePassword() async throws {
        let password = "12345678"
        
        try await AuthManage.shared.updatePassword(password: password)
    }
    
    func updateEmail() async throws {
        let newEmail = "Abc@gmail.com"
        
        try await AuthManage.shared.updateEmail(email: newEmail)
    }
    
}

struct SettingsView: View {
    @State private var vm = SettingsViewModel()
    @Binding var showSignedInView: Bool
    
    var body: some View {
        List{
            Button("Log out"){
                Task{
                    do{
                        try vm.signOut()
                        showSignedInView = true
                    }catch{
                        print(error)
                    }
                }
            }
            if vm.authProviders.contains(.email){
                emailSection
            }
            
            

        }
        .onAppear{
            vm.fetchAuthProviders()
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView(showSignedInView: .constant(false))
}


extension SettingsView {
    
    private var emailSection: some View {
        Section {
            Button("Reset Password"){
                Task{
                    do{
                        try await vm.resetPassword()
                        print("Password Reset")
                    }catch{
                        print(error)
                    }
                }
            }
            
            
            Button("Update Password"){
                Task{
                    do{
                        try await vm.updatePassword()
                        print("Password Updated")
                    }catch{
                        print(error)
                    }
                }
            }
            
            Button("Update Email"){
                Task{
                    do{
                        try await vm.updateEmail()
                        print("Email Updated")
                    }catch{
                        print(error)
                    }
                }
            }
        } header: {
            Text("Email Functions")
        }
    }
    
}
