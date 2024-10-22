//
//  FirebaseAuthentication.swift
//  com.wruv.ljmayo.www
//
//  Created by user249214 on 10/21/24.
//
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseAuthService {
    let db = Firestore.firestore()

    // create new user
    func registerUser(email: String, password: String) -> Error? {
        var registrationError: Error? = nil

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                registrationError = error
            }
            else if let authResult = authResult {
                // Save user data to Firestore
                let userData: [String: Any] = [
                    "email": email,
                    "uid": authResult.user.uid
                ]
                self.db.collection("Users").document(authResult.user.uid).setData(userData) { error in
                    if let error = error {
                        registrationError = error
                    }
                }
            }
        }

        return registrationError
    }

    // sign in as existing user
    func loginUser(email: String, password: String) -> String? {
        var loginErrorMessage: String? = nil
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .wrongPassword:
                    loginErrorMessage = "Incorrect password. Please try again."
                case .invalidEmail:
                    loginErrorMessage = "Invalid email address."
                case .userNotFound:
                    loginErrorMessage = "User not found. Please register."
                default:
                    loginErrorMessage = error.localizedDescription
                }
            }
        }
    
        return loginErrorMessage
    }
}
