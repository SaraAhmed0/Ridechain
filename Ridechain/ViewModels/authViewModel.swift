//
//  authViewModel.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 26/05/1444 AH.
//

import Foundation
import FirebaseAuth

class authViewModel: ObservableObject{ //signin and up without auth
    @Published var signedIn = false
    let auth = Auth.auth()
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    
    
    func signIn(email:String, password:String){
        
        auth.signIn(withEmail: email,
                    password: password){ [weak self] result,
            error in
            guard result != nil, error == nil else{
                return
            }
            
            //success
            DispatchQueue.main.async {
                self?.signedIn = true

            }
        }
    }
    
    func signUp (email:String, password:String){
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            //success
            DispatchQueue.main.async {
                self?.signedIn = true

            }

        }
    }
    
    func signOut(){
        
        try?  auth.signOut()
          
          self.signedIn = false
    }

}
