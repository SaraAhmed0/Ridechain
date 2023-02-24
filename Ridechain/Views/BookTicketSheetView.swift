//
//  BookTicketSheetView.swift
//  TicketBooking
//
//  Created by Sara AlMezeini on 09/01/2023.
//

import Foundation
import SwiftUI
import FirebaseAuth
struct BookTicketSheetView: View {
    @EnvironmentObject var dbTicket: TicketVM
    @EnvironmentObject var passengerVM: PassengerVM
    @EnvironmentObject var dbRide: RideVM
    @EnvironmentObject var randomId: RandomIdGenerator
    @Environment(\.dismiss) var dismiss
    var ride: Ride
    @State var totalPrice: Double = 0.0
    @State var totalTickets: Int = 1
    @State var showingAlert = false
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image("vline")
                    VStack(spacing:159) {
                        VStack {
                            
                            
                            Text("From")
                                .scaledFont(name: .medium, size: 16)
                                .foregroundColor(.lightGreen)
                      
                            Text(ride.ridePickup ?? "")
                                .scaledFont(name: .medium, size: 16)
                            
                            Text(ride.rideStartTime?.getTime() ?? "")
                                .scaledFont(name: .medium, size: 12)
                                .foregroundColor(.lightGreen)
                        }
                        VStack {
                            
                            
                            Text("To")
                                .scaledFont(name: .medium, size: 16)
                                .foregroundColor(.lightGreen)
                            
                            
                            Text(ride.rideDropoff ?? "")
                                .scaledFont(name: .medium, size: 16)
                            
                            
                            Text(ride.rideStartTime?.adding(minutes: ride.rideDuration ?? 0) ?? "")
                                .scaledFont(name: .medium, size: 12)
                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.66, blue: 0.72, alpha: 1)))
                        }
                        
                    }
                    
                }
                Spacer()
                VStack(alignment:.leading,spacing:27) {
                    
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: "calendar")
                            .foregroundColor(.lightGreen)
                        
                        
                        VStack(alignment: .leading){
                            Text("Date")
                                .scaledFont(name: .medium, size: 16)
                                .foregroundColor(.lightGreen)
                            
                            
                            Text(ride.rideDate ?? Date(), style: .date)
                                .scaledFont(name: .medium, size: 16)
                        }
                    }
                    
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: ride.rideType == "Metro" ? "tram.fill" : "bus.fill")
                            .foregroundColor(.lightGreen)
                        
                        
                        VStack(alignment: .leading){
                            Text("Type")
                                .scaledFont(name: .medium, size: 16)
                                .foregroundColor(.lightGreen)
                            
                            
                            Text(ride.rideType ?? "")
                                .scaledFont(name: .medium, size: 16)
                        }
                    }
                    
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: "person.3")
                            .foregroundColor(.lightGreen)
                        
                        
                        VStack(alignment: .leading){
                            Text("Availability")
                                .scaledFont(name: .medium, size: 16)
                                .foregroundColor(.lightGreen)
                            
                            
                            Text("\(ride.rideCapacity ?? 0) Seats")
                                .scaledFont(name: .medium, size: 16)
                        }
                    }
                    
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: "ticket")
                            .foregroundColor(.lightGreen)
                        
                        
                        VStack(alignment: .leading){
                            Text("Price")
                                .scaledFont(name: .medium, size: 16)
                                .foregroundColor(.lightGreen)
                            
                            
                            Text("\(ride.ridePrice?.getIn2Decimal() ?? "") SAR")
                                .scaledFont(name: .medium, size: 16)
                        }
                    }
                    
                }
            }
            
            Divider()
            HStack {
                
                Button {
                    if totalTickets != 1 {
                        totalPrice -= ride.ridePrice ?? 0
                        totalTickets -= 1
                    }
                } label: {
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.seaGreen)
                            .frame(width: 40, height: 43)
                        
                        
                        Image(systemName: "minus")
                            .foregroundColor(.parrotColor)
                        
                    }
                }
                
                Text(totalTickets.description)
                    .scaledFont(name: .medium, size: 28)
                    .foregroundColor(Color(#colorLiteral(red: 0.42, green: 0.4, blue: 0.4, alpha: 1)))
                Button {
                    totalPrice += ride.ridePrice ?? 0
                    totalTickets += 1
                } label: {
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.seaGreen)
                            .frame(width: 40, height: 43)
                        
                        
                        Image(systemName: "plus")
                            .foregroundColor(.parrotColor)
                    }
                }
                
                Spacer()
                
                Button {
                    
                    guard let id = Auth.auth().currentUser?.uid else {return}
                    let totalPrice = calculatePrice(ride, totalTickets)
                    let passenger = passengerVM.passengers.filter({$0.id == id}).first
                    
                    if let passenger, let balance = passenger.walletBalance, balance >= totalPrice {
                        var updatedPassenger = passenger
                        updatedPassenger.walletBalance! -= totalPrice
                        passengerVM.updateWallet(updatedPassenger)
                        updatedPassenger.walletTokens! += 5
                        passengerVM.updateToken(updatedPassenger)
                        
                        dbTicket.issueTicket(ride, totalTickets, calculatePrice(ride, totalTickets), randomId.randomIds[0].number)
                        randomId.incrementCounter()
                        
                        NotificationCenter.default.post(name: Notification.didBookTicket, object: nil)
                        dismiss()
                    } else {
                        showingAlert.toggle()
                    }
                    
                    
                } label: {
                    ZStack {
                        
                        //Rectangle 6
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.parrotColor)
                            .frame(width: 202, height: 43)
                        
                        //Total : 25 SAR
                        Text("Total : \(totalPrice.getIn2Decimal()) SAR")
                            .font(.custom("Roboto Medium", size: 20))
                            .foregroundColor(Color.white)
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text("Insufficient Wallet"), message: Text("Wallet balance not enough please charge the wallet"), dismissButton: .default(Text("Ok")))
                    }
                }
                
                
            }
        }.padding(.horizontal, 22)
            .frame(height: 410)
            .onAppear(){
                totalPrice = ride.ridePrice ?? 0
            }
    }
    func calculatePrice(_ ride:  Ride, _ numOfTickets : Int) -> Double{
        var price = (ride.ridePrice ?? 0)*(Double(numOfTickets))
        var newPrice = round(price * 100)/100.0
        return newPrice
        
    }
    
    
}

//struct BookTicketSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookTicketSheetView(ticket: Ticket.demoTicket)
//    }
//}

extension Double{
    func getIn2Decimal() -> String {
        return String(format: "%.2f", self)
    }
}
extension Notification {
    static let didBookTicket = Notification.Name("didBookTicket")
    static let viewTicket = Notification.Name("viewTicket")
}
