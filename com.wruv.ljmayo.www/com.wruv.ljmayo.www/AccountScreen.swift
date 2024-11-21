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
    @State private var isEditingChatName: Bool = false

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
                
                Button(action: {
                    isEditingChatName = true
                }) {
                    Text("Change Chat Name")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .sheet(isPresented: $isEditingChatName) {
                    EditChatNameSheet()
                        .environmentObject(authService)
                }
                
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

struct EditChatNameSheet: View {
    @EnvironmentObject var authService: FirebaseAuthService
    @State private var newChatName: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var shouldNavigateToHome: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter new chat name", text: $newChatName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    if let currentUser = authService.currentUser {
                        authService.updateChatName(newName: newChatName) { error in
                            if let error = error {
                                print("Error updating chat name: \(error)")
                            } else {
                                print("Chat name updated successfully")
                                shouldNavigateToHome = true
                                dismiss()
                            }
                        }
                    }
                }) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                Spacer()
            }
            .navigationTitle("Edit Chat Name")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    let mockAuthService = FirebaseAuthService()
    mockAuthService.currentUser = User(email: "mockuser@example.com", chatName: "MockUser")
    return AccountScreen()
        .environmentObject(mockAuthService)
}
