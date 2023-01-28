//
//  RideBookingApp.swift
//  RideBooking
//
//  Created by Jawaher on 08/01/2023.
//

import SwiftUI
import FirebaseCore

@main
struct RideBookingApp: App {
    @ObservedObject var dbTicket: TicketVM
    init() {
        FirebaseApp.configure()
        dbTicket = TicketVM()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
                    .environmentObject(dbTicket)
            }
        }
        
    }
}
