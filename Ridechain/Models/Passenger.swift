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
    var passengerEmail: String?
    var passengerPassword: String?
    var passengerName: String?
    var walletBalance: Double?
    var walletTokens: Int?

    
    init(passengerEmail: String? = "", passengerPassword: String? = "",  passengerName: String? = "", walletBalance: Double? = 0.0, walletTokens: Int? = 0  ) {
        self.passengerEmail = passengerEmail
        self.passengerPassword = passengerPassword
        self.passengerName = passengerName
        self.walletBalance = walletBalance
        self.walletTokens = walletTokens
    }
}
