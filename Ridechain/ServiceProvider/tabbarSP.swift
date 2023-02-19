//
//  tabbar.swift
//  ServiceProvider
//
//  Created by Danah  on 30/01/2023.
//

import SwiftUI

struct tabbarSP: View {
//    var user : Passenger
    var body: some View {
        TabView {
            sprides()
                .tabItem {
                    Label("Schedule", systemImage: "calendar")
                }
         
           addRide()
                .tabItem {
                    Label("Add", systemImage: "plus.circle.fill")
                }
  
        SearchViewSP()
                 .tabItem {
                     Label("Search", systemImage: "magnifyingglass")
                 }
        }.tint(Color("lgreen"))
    }
}

//struct tabbarSP_Previews: PreviewProvider {
//    static var previews: some View {
//        tabbarSP()
//    }
//}
