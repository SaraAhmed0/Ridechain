//
//  BookTicketSheetView.swift
//  TicketBooking
//
//  Created by Sara AlMezeini on 09/01/2023.
//

import Foundation
import SwiftUI

struct BookTicketSheetView: View {
    @EnvironmentObject var dbTicket: TicketVM
    @Environment(\.dismiss) var dismiss
    var ride: Ride
    @State var totalPrice: Double = 0.0
    @State var totalTickets: Int = 1
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
                            
                            
                            Text(ride.rideDate?.getFormatted() ?? "")
                                .scaledFont(name: .medium, size: 16)
                        }
                    }
                    
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: "calendar")
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
                        Image(systemName: "calendar")
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
                        Image(systemName: "calendar")
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
                    dbTicket.issueTicket(ride, totalTickets, calculatePrice(ride, totalTickets), Int.random(in: 1...9999))
                    NotificationCenter.default.post(name: Notification.didBookTicket, object: nil)
                    dismiss()
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
