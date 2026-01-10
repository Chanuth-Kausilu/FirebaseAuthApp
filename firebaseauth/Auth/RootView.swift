//
//  RootView.swift
//  firebaseauth
//
//  Created by Chanuth Kausilu on 2026-01-06.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignedInView: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                SettingsView(showSignedInView: $showSignedInView)
            }
        }
        .onAppear{
            let authUser = try? AuthManage.shared.getAuthenticatedUser()
            self.showSignedInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignedInView){
            NavigationStack{
                AuthView(showSignedInView: $showSignedInView)
            }
        }
        
    }
}

#Preview {
    RootView()
}
