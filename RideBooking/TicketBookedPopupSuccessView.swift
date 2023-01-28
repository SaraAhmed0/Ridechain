//
//  BookTicketBottomSheetView.swift
//  TicketBooking
//
//  Created by Jawaher on 09/01/2023.
//

import SwiftUI

struct TicketBookedPopupSuccessView: View {
    
    @Binding var showTicketPopupView: Bool
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.darkGreen)
                        .frame(height: 331)
                    
                    VStack(spacing:20) {
                        Text("Ride has been booked !")
                            .scaledFont(name: .bold, size: 24)
                            .foregroundColor(.white)
                        
                        Image("star")
                            .resizable()
                            .frame(width: 95, height: 95)
                        
                        Text("You have earned 5 loyalty points")
                            .scaledFont(name: .bold, size: 18)
                            .foregroundColor(.white)
                        
                        Button {
                            print("View Ticket")
                            showTicketPopupView.toggle()
                            NotificationCenter.default.post(name: Notification.viewTicket, object: nil)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.parrotColor)
                                    .frame(width: 172, height: 42)
                                
                                Text("View Ticket")
                                    .scaledFont(name: .medium, size: 18)
                                    .foregroundColor(.white)
                                
                            }
                        }
                        
                    }
                    
                }
                .padding(.horizontal, 25)
                
                
            }
            
        }
        
    }
}

struct TicketBookedPopupSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        TicketBookedPopupSuccessView(showTicketPopupView: .constant(false))
    }
}
