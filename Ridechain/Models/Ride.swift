//
//  Ride.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 26/05/1444 AH.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class Ride: Codable, Identifiable{
    @DocumentID var id : String?
    var rideStartTime: Date?
    var rideDate: Date?
    var rideType: String?
    var ridePrice: Double?
    var rideCapacity: Int?
    var ridePickup: String?
    var rideDropoff: String?
    var rideDuration: Int?
    
    
    
    init(rideStartTime: Date? = Date(), rideDate: Date? = Date(),  rideType: String? = "", ridePrice: Double? = 0.0, rideCapacity: Int? = 0, ridePickup: String = "", rideDropoff:String? = "" , rideDuration: Int? = 0 ) {
        self.rideStartTime = rideStartTime
        self.rideDate = rideDate
        self.rideType = rideType
        self.ridePrice = ridePrice
        self.rideCapacity = rideCapacity
        self.ridePickup = ridePickup
        self.rideDropoff = rideDropoff
        self.rideDuration = rideDuration
    }
}

func decrementCapacity( _ ride :Ride, _ newCapacity :Int){
    var capacity = ride.rideCapacity ?? 0 - newCapacity
    
    
    
}
