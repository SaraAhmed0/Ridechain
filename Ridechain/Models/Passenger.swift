//
//  Passenger.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 26/05/1444 AH.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class Passenger: Codable, Identifiable{
    
   @DocumentID var id : String?
    var passengerNationalID: String?
    var passengerEmail: String?
    var passengerPassword: String?
    var passengerName: String?
    var walletBalance: Double?
    var walletTokens: Int?
    var spLocation: String?
    var userType: String?

    
    init( userType: String? = "", passengerNationalID:String? = "", passengerEmail: String? = "", passengerPassword: String? = "",  passengerName: String? = "", walletBalance: Double? = 0.0, walletTokens: Int? = 0 ) {
        self.passengerNationalID = passengerNationalID
        self.passengerEmail = passengerEmail
        self.passengerPassword = passengerPassword
        self.passengerName = passengerName
        self.walletBalance = walletBalance
        self.walletTokens = walletTokens
        self.userType = userType
    }
    
    init(userType: String? = "", passengerEmail: String? = "", passengerPassword: String? = "",  passengerName: String? = "", spLocation: String? = "" ) {

        self.passengerEmail = passengerEmail
        self.passengerPassword = passengerPassword
        self.passengerName = passengerName
        self.spLocation = spLocation
        self.userType = userType
     
    }
    
    func user(id: String, users: [Passenger]) -> Passenger{
      var user : Passenger = Passenger()
        var userType = ""
        for i in users{
          if i.id == id {
            user = i
            print("id: "+id)
            userType = user.userType ?? ""
          }
        }
        print("usertype is: "+userType)
        return user
      }
}
