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

class ServiceProvider: Codable, Identifiable{
    
   @DocumentID var id : String?
    var spEmail: String?
    var spPassword: String?
    var spName: String?
    var spLocation: String?
 

    
    init(spEmail: String? = "", spPassword: String? = "",  spName: String? = "", spLocation:String? = "" ) {

        self.spEmail = spEmail
        self.spPassword = spPassword
        self.spName = spName
        self.spLocation = spLocation


    }
}
