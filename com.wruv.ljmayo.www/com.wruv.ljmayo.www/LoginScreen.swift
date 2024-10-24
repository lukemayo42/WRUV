import SwiftUI

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var showRegistration: Bool = false  // State to manage pop-up

    var body: some View {
        ZStack {
            // Set black background
            Color.black
                .edgesIgnoringSafeArea(.all)

            VStack {
                // WRUV Logo at the top
                Image("wruvlogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 50)

                Spacer().frame(height: 50)

                // Email Input
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .keyboardType(.emailAddress)

                // Password Input
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)

                // Login Button
                Button(action: {
                    isLoggedIn = true
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

                // Continue as Guest Button
                Button(action: {
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

                // Register Button
                Button(action: {
                    showRegistration = true
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
                RegistrationView(showRegistration: $showRegistration)
            }
        }
    }
}

struct RegistrationView: View {
    @Binding var showRegistration: Bool
    @State private var newEmail: String = ""
    @State private var newPassword: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Registration form
                TextField("Enter your email", text: $newEmail)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .keyboardType(.emailAddress)

                SecureField("Enter your password", text: $newPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)

                // Submit Button
                Button(action: {
                    showRegistration = false
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

