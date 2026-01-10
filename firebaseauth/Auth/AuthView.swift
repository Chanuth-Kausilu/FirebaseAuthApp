//
//  AuthView.swift
//  firebaseauth
//
//  Created by Chanuth Kausilu on 2026-01-05.
//

import SwiftUI

struct AuthView: View {
    
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
