import SwiftUI
import FirebaseAuth

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showRegistration: Bool = false
    @State private var loginErrorMessage: String? = nil
    @State private var isLoggedIn: Bool = false // Local state for login status
    
    var auth = FirebaseAuthService()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                Image("wruvlogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 50)
                
                Spacer().frame(height: 50)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)

                // Login Button action in LoginScreen
                // LoginScreen.swift
                Button(action: {
                    auth.loginUser(email: email, password: password) { errorMessage in
                        DispatchQueue.main.async {
                            if let error = errorMessage {
                                loginErrorMessage = error
                                print("Login error: \(error)")  // Debug statement
                            } else {
                                isLoggedIn = true
                                print("Login successful, navigating to HomeView")  // Debug statement
                            }
                        }
                    }
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 20)

                if let errorMessage = loginErrorMessage {
                    Text(errorMessage).foregroundColor(.red).padding()
                }

                Button(action: {
                    do {
                        try Auth.auth().signOut()
                    } catch let signOutError {
                        print("Error signing out: \(signOutError.localizedDescription)")
                    }
                    isLoggedIn = true
                }) {
                    Text("Continue as Guest")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 10)

                Button(action: {
                    showRegistration = true
                    print("Registration sheet presented")  // Debug statement
                }) {
                    Text("Register")
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                }

                Spacer()
            }
            .fullScreenCover(isPresented: $isLoggedIn) {
                HomeView()
            }
            .sheet(isPresented: $showRegistration) {
                RegistrationView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}


// sheet pop up for registering new account
struct RegistrationView: View {
    @Binding var isLoggedIn: Bool // Binding to control login status
    @State private var newEmail: String = ""
    @State private var newPassword: String = ""
    @State private var reEnterPassword: String = ""
    @State private var registrationErrorMessage: String? = nil
    @State private var registrationSuccessMessage: String? = nil
    
    var authService = FirebaseAuthService()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your email", text: $newEmail)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)

                SecureField("Enter your password", text: $newPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)

                SecureField("Re-enter your password", text: $reEnterPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)

                Button(action: {
                    if newPassword != reEnterPassword {
                        registrationErrorMessage = "Passwords do not match."
                        registrationSuccessMessage = nil
                        print("Password mismatch")  // Debug statement
                    } else {
                        authService.registerUser(email: newEmail, password: newPassword) { errorMessage in
                            DispatchQueue.main.async {
                                if let error = errorMessage {
                                    registrationErrorMessage = error
                                    registrationSuccessMessage = nil
                                    print("Registration error: \(error)")  // Debug statement
                                } else {
                                    registrationSuccessMessage = "Registration successful!"
                                    registrationErrorMessage = nil
                                    print("Registration successful, setting isLoggedIn to true")  // Debug statement
                                    isLoggedIn = true  // Assuming this exists in RegistrationView
                                }
                            }
                        }
                    }
                }) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 20)
                
                if let errorMessage = registrationErrorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Spacer()
            }
            .navigationTitle("Register")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LoginScreen()
}
