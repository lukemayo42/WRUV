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
    func registerUser(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Registration error: \(error.localizedDescription)")
                completion(error.localizedDescription)
            } else if let authResult = authResult {
                // Save user data to Firestore's Accounts collection
                let userData: [String: Any] = [
                    "email": email,
                    "uid": authResult.user.uid
                ]
                self.db.collection("Accounts").document(authResult.user.uid).setData(userData) { error in
                    if let error = error {
                        print("Firestore saving error: \(error.localizedDescription)")
                        completion(error.localizedDescription)
                    } else {
                        // Registration success, calling completion on the main thread
                        DispatchQueue.main.async {
                            print("Registration successful, user data saved to Accounts collection")
                            completion(nil)
                        }
                    }
                }
            }
        }
    }


    // FirebaseAuthentication.swift
    func loginUser(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .wrongPassword:
                    completion("Incorrect password. Please try again.")
                case .invalidEmail:
                    completion("Invalid email address.")
                case .userNotFound:
                    completion("User not found. Please register.")
                default:
                    completion(error.localizedDescription)
                }
            } else {
                completion(nil) // No error means login successful
            }
        }
    }
    
    
    // Move account data from Accounts to Users collection
        func moveAccountToUsersCollection(userId: String) {
            let userDocRef = db.collection("Accounts").document(userId)
            userDocRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let userData = document.data() ?? [:]
                    self.db.collection("Users").document(userId).setData(userData) { error in
                        if let error = error {
                            print("Error moving account data to Users: \(error.localizedDescription)")
                        } else {
                            // Optionally, delete the original account document
                            userDocRef.delete { error in
                                if let error = error {
                                    print("Error deleting account data: \(error.localizedDescription)")
                                }
                            }
                            print("User data moved to Users collection successfully.")
                        }
                    }
                }
            }
        }

}
