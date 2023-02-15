//
//  TicketViewModel.swift
//  RideBooking
//
//  Created by Sara AlMezeini on 13/01/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth


class TicketVM: ObservableObject {
    let dbTicket = Firestore.firestore()
    
    @Published var tickets = [Ticket]()
    @Published var bookedTicket: Ticket?
    
    
    init(){
        self.loadData()
    }
    
    func loadData(){
        
        if (Auth.auth().currentUser?.uid != nil){
            dbTicket.collection("Tickets").addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.tickets = querySnapshot.documents.compactMap { document in
                        do{
                            let ticket =  try document.data(as: Ticket.self)
                            if (ticket.ticketOwner == Auth.auth().currentUser?.uid){
                            print(ticket.dropoff)
                                return ticket
                                
                            }
                        }
                        catch {
                            print(error)
                        }
                        return nil
                    }
                }
                
            }
        }
        
    }
    
    
    func addTicket(_ ticket :Ticket){
        do{
            ticket.ticketOwner = Auth.auth().currentUser?.uid
            bookedTicket = ticket
            var _ = try dbTicket.collection("Tickets").addDocument(from: ticket)
        }
        catch{
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
        
    }
    
    
    func updateTicket(_ ticket :Ticket){
        do {
            guard let id = ticket.id else {return}
            try dbTicket.collection("Tickets").document(id).setData(from: ticket)
        } catch {
            print("Unable to encode task: \(error.localizedDescription)")
        }
        
        
    }
    
    func issueTicket(_ ride : Ride, _ total : Int, _ price : Double, _ id : Int){
        var dbRide = RideVM()
        let ticket = Ticket(relatedRide: ride.id, totaltickets: total, invoiceNo: id,
                            time: ride.rideStartTime, date: ride.rideDate,
                            duration: ride.rideDuration, price: price,
                            dropoff: ride.rideDropoff, pickup: ride.ridePickup,
                            type: ride.rideType)
        addTicket(ticket)
        dbRide.decrementCapacity(ride, total)
        
    }
    
    
    
}
