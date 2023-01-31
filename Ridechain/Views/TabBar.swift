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
            Today()
                .tabItem {
                    Label("Today", systemImage: "list.dash")
                }
            
         SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle.fill")
                }
            mytickets()
             .tabItem {
                    Label("Tickets", systemImage: "ticket.fill")
               }
            walletPage()
                .tabItem {
                    Label("Wallet", systemImage: "ticket")
                }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
