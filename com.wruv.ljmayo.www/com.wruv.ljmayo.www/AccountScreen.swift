//
//  AccountScreen.swift
//  com.wruv.ljmayo.www
//
//  Created by Max Schwarz on 10/5/24.
//
import SwiftUI

struct AccountScreen: View {
    @EnvironmentObject var authService: FirebaseAuthService
    @State private var errorMessage: String?

    var body: some View {
        Spacer(minLength: 70)
        VStack {
            if let user = authService.currentUser {
                Text("Welcome, \(user.chatName)")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                Text("Email: \(user.email)")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                Text("No user information available")
                    .font(.title)
                    .padding()
            }
            Spacer()
        }
        .onAppear {
            authService.fetchCurrentUser { error in
                if let error = error {
                    self.errorMessage = error
                } else {
                    self.errorMessage = nil
                }
            }
        }
    }
}


#Preview {
    let mockAuthService = FirebaseAuthService()
    mockAuthService.currentUser = User(email: "mockuser@example.com", chatName: "MockUser")
    return AccountScreen()
        .environmentObject(mockAuthService)
}
