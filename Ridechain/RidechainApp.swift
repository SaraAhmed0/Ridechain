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
    
    init() {
        FirebaseApp.configure()
        viewModel = authViewModel()
    }
    var body: some Scene {
        WindowGroup {
            SignViews()
                .environmentObject(viewModel)
            
        }

    }
    

}
