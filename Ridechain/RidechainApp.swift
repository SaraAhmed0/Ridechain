//
//  RidechainApp.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 19/05/1444 AH.
//

import SwiftUI
//import Firebase


@main
struct RidechainApp: App {
    
    // @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()//for sign in/up
            ContentView()
                .environmentObject(viewModel)        }

    }
    
    /*class AppDelegate: NSObject, UIApplicationDelegate{
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
         
         FirebaseApp.configure()
         return true
     }*/
}
