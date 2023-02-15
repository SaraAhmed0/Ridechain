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
    
    func calculateDuration(_ startTime : Date, duration: Int) -> Date {
        
        // convert Date to TimeInterval (typealias for Double)
        let timeInterval = startTime.timeIntervalSince1970

        // convert to Integer
        let timeInt = Int(timeInterval)
        let newduration = duration * 60
        let endTime = newduration + timeInt
        
        let endTimeFormat = TimeInterval(endTime)

        // create NSDate from Double (NSTimeInterval)
        let myNSDate = Date(timeIntervalSince1970: endTimeFormat)
        print(duration)
        print(myNSDate)
        return myNSDate
        
    }

}


