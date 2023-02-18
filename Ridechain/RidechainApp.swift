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
    @ObservedObject var randomId: RandomIdGenerator

    
    init() {
        FirebaseApp.configure()
        viewModel = authViewModel()
        dbPassenger = PassengerVM()
        dbRide = RideVM()
        dbTicket = TicketVM()
        randomId = RandomIdGenerator()
        UITabBar.appearance().backgroundColor = UIColor(.white)
//        UITableView.appearance().backgroundColor = UIColor(named: "seaGreen")
    }
    var body: some Scene {
        WindowGroup {
            splashscreen()
                .environmentObject(viewModel)
                .environmentObject(dbPassenger)
                .environmentObject(dbRide)
                .environmentObject(dbTicket)
                .environmentObject(randomId)
//            ContentView()
//                .environmentObject(dbRide)
//                .environmentObject(randomId)
//            tabbarSP()
//                .environmentObject(dbRide)
//                .environmentObject(dbTicket)
//            SignViews()
//                .environmentObject(viewModel)
//                .environmentObject(dbPassenger)
//                .environmentObject(dbRide)
//                .environmentObject(dbTicket)
//                .environmentObject(randomId)

            
        }

    }
    

}
