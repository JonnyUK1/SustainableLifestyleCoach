import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

class AuthViewModel: ObservableObject {
    // This is the firebase user object
    @Published var userSession: FirebaseAuth.User?
    // This is the user datamodel
    @Published var currentUser: User?
    
    
    
    init(){
        //check if a user is alread logged in, it is cashed on the device itself
        self.userSession = Auth.auth().currentUser
        
        
        Task {
            await fetchUser()
        }
        
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to login with error \(error.localizedDescription)")
        }
    }
    
    //Async function to throw an error if something goes wrong
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            //This is how the information is uploaded to firebase a 'Document' of users is created
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print ("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            //Wipes user session
            self.userSession = nil
            //Wipes out current user data model
            self.currentUser = nil
        } catch {
            print ("DEBUG: Failed to signout with error \(error.localizedDescription)")
        }
        
    }
    
    func deleteAccount(){
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("DEBUG Current User is\(self.currentUser)")
    }
}
