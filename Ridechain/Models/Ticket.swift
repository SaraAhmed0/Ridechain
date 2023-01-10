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
}
