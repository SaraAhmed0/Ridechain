//
//  Ticket.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 26/05/1444 AH.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class Ticket: Codable, Identifiable {
     @DocumentID var id : String?
    var ticketOwner : String?
    var relatedRide: String?
    var totaltickets: Int?
    var invoiceNo: Int?
    var date : Date?
    var time : Date?
    var duration : Int?
    var price : Double?
    var dropoff : String?
    var pickup : String?
    var type : String?
    
    init(relatedRide: String? = "", totaltickets: Int? = 0, invoiceNo: Int? = 0, time : Date? = Date(), date : Date? = Date(), duration : Int? = 0,
         price : Double? = 0.0,
        dropoff : String? = "",
        pickup : String? = "",
        type : String? = ""){
        
        self.relatedRide = relatedRide
        self.totaltickets = totaltickets
        self.invoiceNo = invoiceNo
        self.time = time
        self.date = date
        self.duration = duration
        self.price = price
        self.dropoff = dropoff
        self.pickup = pickup
        self.type = type
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
