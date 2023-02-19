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

class PassengerVM: ObservableObject {
    let dbPassenger = Firestore.firestore()
    
    @Published var passengers = [Passenger]()
    
    
    init(){
        loadData()
    }
    
    func loadData(){
            dbPassenger.collection("Passengers").addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.passengers = querySnapshot.documents.compactMap { document in
                        do{
                            let x =  try document.data(as: Passenger.self)
                                return x
                        }
                        catch {
                            print(error)
                        }
                        return nil
                    }
                }
        }
    }
    
    
    func addUser(_ passenger :Passenger){
        do{
            if let id = Auth.auth().currentUser?.uid {
                var _ = try dbPassenger.collection("Passengers").document(id).setData(from: passenger)
            }
        }
        catch{
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
        
    }
    
    func updateToken(_ passenger :Passenger){
        do{
            if let id = Auth.auth().currentUser?.uid {
                var _ = try dbPassenger.collection("Passengers").document(id).setData(from: passenger)
            }
        }
        catch{
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
        
    }
    
    func updateWallet(_ passenger :Passenger){
        do{
            if let id = Auth.auth().currentUser?.uid {
                var _ = try dbPassenger.collection("Passengers").document(id).setData(from: passenger)
            }
        }
        catch{
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
        
    }
    
    func updateWallet(_ passengers : [Passenger], _ newBalance :Double ){
        do{
            for passenger in passengers {
                if (passenger.id == Auth.auth().currentUser?.uid) {
                    var _ = try dbPassenger.collection("Passengers").document(passenger.id ?? "").setData(from: ["walletBalance" : (passenger.walletBalance ?? 0) + newBalance],merge: true)
                }
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
