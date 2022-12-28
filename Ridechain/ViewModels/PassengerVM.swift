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
            var _ = try dbPassenger.collection("Passengers").addDocument(from: passenger)
        }
        catch{
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
        
    }
    
    
}
