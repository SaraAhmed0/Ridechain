//
//  RideVM.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 04/06/1444 AH.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class RideVM: ObservableObject {
    let dbRide = Firestore.firestore()
    
    @Published var rides = [Ride]()
    
    
    init(){
        loadData()
    }
    
    func loadData(){
        dbRide.collection("Rides").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.rides = querySnapshot.documents.compactMap { document in
                    do{
                        let x =  try document.data(as: Ride.self)
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
    
    
    func addRide(_ ride :Ride){
        do{
            var _ = try dbRide.collection("Rides").addDocument(from: ride)
        }
        catch{
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
        
    }
    

    
    func decrementCapacity( _ ride :Ride, _ newCapacity :Int){
        do {
            guard let id = ride.id else {return}
            try dbRide.collection("Rides").document(id).setData(from: ["rideCapacity": (ride.rideCapacity ?? 0) - newCapacity],merge: true)
        } catch {
            print("Unable to encode task: \(error.localizedDescription)")
        }
        
        
    }
    
    func updatePrice(_ ride :Ride, _ newCapacity :Int){
        
    }
    
    
    
}
