//
//  RidechainApp.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 19/05/1444 AH.
//

import SwiftUI
import Firebase


@main
struct RidechainApp: App {
    @ObservedObject var viewModel: authViewModel
    @ObservedObject var dbPassenger: PassengerVM
    @ObservedObject var dbRide: RideVM
    @ObservedObject var dbTicket: TicketVM
    
    init() {
        FirebaseApp.configure()
        viewModel = authViewModel()
        dbPassenger = PassengerVM()
        dbRide = RideVM()
        dbTicket = TicketVM()
    }
    var body: some Scene {
        WindowGroup {
            SignViews()
                .environmentObject(viewModel)
                .environmentObject(dbPassenger)
                .environmentObject(dbRide)
                .environmentObject(dbTicket)
            
        }

    }
    

}
