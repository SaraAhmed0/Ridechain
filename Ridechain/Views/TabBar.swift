//
//  TabBar.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 11/06/1444 AH.
//

import SwiftUI

struct TabBar: View {
    
    init() {
//         authViewModel()
//         PassengerVM()
//         RideVM()
//         TicketVM()
        UITabBar.appearance().backgroundColor = UIColor(named: "tabbar")
    }
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            //-----------------
            walletPage()
                .tabItem {
                    Label("Wallet", systemImage: "ticket")
                }
            //-----------------
//            ContentView()
//                .tabItem {
//                    Label("Menu", systemImage: "list.dash")
//               }
         
            mytickets()
             .tabItem {
                    Label("Tickets", systemImage: "ticket.fill")
               }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
