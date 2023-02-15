//
//  TabBar.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 11/06/1444 AH.
//

import SwiftUI

struct TabBar: View {
    var user : Passenger

    var body: some View {
        TabView {
            Today()
                .tabItem {
                    Label("Rides", systemImage: "list.dash")
                }
            
         SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle.fill")
                }
            mytickets()
             .tabItem {
                    Label("Tickets", systemImage: "wallet.pass")
               }
            walletPage()
                .tabItem {
                    Label("Wallet", systemImage: "ticket")
                }
        }
    }
}

//struct TabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBar()
//    }
//}
