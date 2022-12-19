//
//  RidechainApp.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 19/05/1444 AH.
//

import SwiftUI

@main
struct RidechainApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()//for sign in/up
            ContentView()
                .environmentObject(viewModel)        }

    }
}
