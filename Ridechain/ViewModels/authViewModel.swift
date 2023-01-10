//
//  authViewModel.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 26/05/1444 AH.
//

import Foundation
import FirebaseAuth
import Firebase
import SwiftUI

class authViewModel: ObservableObject{ //signin and up without auth
    
    
    @Published var signedIn = false

    
    let auth = Auth.auth()
    @ObservedObject var dbPassenger : PassengerVM = PassengerVM()
    
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
    
    func signUp (nationalID:String, name:String, email:String, password:String){
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            //success
            DispatchQueue.main.async {
                self?.signedIn = true
                self?.dbPassenger.addUser(Passenger(passengerNationalID: nationalID, passengerEmail: email, passengerPassword: password, passengerName: name, walletBalance: 100.0, walletTokens: 0))

            }

        }
    }
    
    func signOut(){
        
        try?  auth.signOut()
          
          self.signedIn = false
    }

}
