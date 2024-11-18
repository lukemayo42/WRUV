//
//  FirebaseAuthentication.swift
//  com.wruv.ljmayo.www
//
//  Created by user249214 on 10/21/24.
//
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseAuthService: ObservableObject {
    let db = Firestore.firestore()
    @Published var currentUser: User?
    
    // Create new user
    func registerUser(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error.localizedDescription)
            } else if let authResult = authResult {
                // Create the User object
                let chatName = email.split(separator: "@").first.map(String.init) ?? email
                let newUser = User(email: email, chatName: chatName)
                DispatchQueue.main.async {
                    self.currentUser = newUser
                }
                
                // save user data to Firestore
                let userData: [String: Any] = [
                    "email": email,
                    "uid": authResult.user.uid,
                    "chatName": chatName
                ]
                self.db.collection("Accounts").document(authResult.user.uid).setData(userData) { error in
                    if let error = error {
                        completion(error.localizedDescription)
                    } else {
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
                }
            }
        }
    }

    // Login user
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
            } else if let authResult = authResult {
                // successfully logged in, now fetch user data from Firestore
                let uid = authResult.user.uid
                self.db.collection("Accounts").document(uid).getDocument { snapshot, error in
                    if let error = error {
                        completion("Error fetching user data: \(error.localizedDescription)")
                    } else if let snapshot = snapshot, snapshot.exists {
                        let data = snapshot.data() ?? [:]
                        let email = data["email"] as? String ?? ""
                        let chatName = data["chatName"] as? String ?? "No Chat Name"
                        let loggedInUser = User(email: email, chatName: chatName)
                        
                        DispatchQueue.main.async {
                            self.currentUser = loggedInUser
                            completion(nil)
                        }
                    } else {
                        completion("User data not found in Firestore.")
                    }
                }
            }
        }
    }
    
    //grab current user if logged in
    func fetchCurrentUser(completion: @escaping (String?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion("No logged-in user.")
            return
        }
            
        db.collection("Accounts").document(uid).getDocument { snapshot, error in
            if let error = error {
                completion("Error fetching user data: \(error.localizedDescription)")
            } else if let snapshot = snapshot, snapshot.exists {
                let data = snapshot.data() ?? [:]
                let email = data["email"] as? String ?? ""
                let chatName = data["chatName"] as? String ?? "No Chat Name"
                let fetchedUser = User(email: email, chatName: chatName)
                
                DispatchQueue.main.async {
                    self.currentUser = fetchedUser
                    completion(nil) // No error
                }
            } else {
                completion("User data not found in Firestore.")
            }
        }
    }
}

