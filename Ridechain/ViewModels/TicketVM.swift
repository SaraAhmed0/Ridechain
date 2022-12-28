//
//  TicketVM.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 26/05/1444 AH.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class TicketVM: ObservableObject {
    let dbTicket = Firestore.firestore()
    
    @Published var tickets = [Ticket]()
    
    
    init(){
       
        loadData()
    }
    
    func loadData(){

            dbTicket.collection("Tickets").addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.tickets = querySnapshot.documents.compactMap { document in
                        do{
                            let x =  try document.data(as: Ticket.self)
                            return x
                        }
                        catch {
                            print(error)
                        }
                        return nil
                    }
                }
                
            }
        
    }
    
    
    func addTicket(_ ticket :Ticket){
        do{
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
    
    func issueTicket(_ ride : Ride, _ total : Int, _ price : Double){
        var ticket = Ticket(relatedRide: ride.id, totaltickets: total, invoiceNo: generateInvoice(), time: ride.rideTime, date: ride.rideDate, duration: ride.rideDuration, price: price, dropoff: ride.rideDropoff, pickup: ride.ridePickup, type: ride.rideType)
        addTicket(ticket)
    }
    
    func generateInvoice() -> Int{
        return Int.random(in: 100000...999999)
    }
    
    
}
