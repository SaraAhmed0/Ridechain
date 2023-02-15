//
//  PassengerVM.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 04/06/1444 AH.
//

import Foundation
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class ServiceProviderVM: ObservableObject {
    let dbServiceProvider = Firestore.firestore()
    
    @Published var sp = [ServiceProvider]()
    
    
    init(){
        loadData()
    }
    
    func loadData(){
        if (Auth.auth().currentUser?.uid != nil){
            dbServiceProvider.collection("ServiceProvider").addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.sp = querySnapshot.documents.compactMap { document in
                        do{
                            let x =  try document.data(as: ServiceProvider.self)
                            if (x.id == Auth.auth().currentUser?.uid){
                                return x
                            }
                        }
                        catch {
                            print(error)
                        }
                        return nil
                    }
                }
                
            }
        }
    }
    
    
    func addServiceProvider(_ sp :ServiceProvider){
        do{
            if let id = Auth.auth().currentUser?.uid {
                var _ = try dbServiceProvider.collection("ServiceProvider").document(id).setData(from: sp)
            }
        }
        catch{
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
        
    }
    
  

    
    func getEmail(_ passengers : [Passenger]) -> String {
        for passenger in passengers {
            if (passenger.id == Auth.auth().currentUser?.uid){
                return passenger.passengerEmail ?? ""
            }
        }
        return "NA"
    }
    
    func getUserName(_ passengers : [Passenger]) -> String {
        for passenger in passengers {
            if (passenger.id == Auth.auth().currentUser?.uid){
                return passenger.passengerName ?? ""
            }
        }
        return "NA"
    }
    func getBalance(_ passengers : [Passenger]) -> Double {
        for passenger in passengers {
            if (passenger.id == Auth.auth().currentUser?.uid){
                return passenger.walletBalance ?? 0.0
            }
        }
        return 0.0
    }
    
    func getTokens(_ passengers : [Passenger]) -> Int {
        for passenger in passengers {
            if (passenger.id == Auth.auth().currentUser?.uid){
                return passenger.walletTokens ?? 0
            }
        }
        return 0
    }
    
    
}
