//
//  ContentView.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 19/05/1444 AH.
//

import SwiftUI

struct ContentView: View {
    
    //Refrence to the database
    @EnvironmentObject var dbPassenger: PassengerVM
    @EnvironmentObject var dbRide: RideVM
    @EnvironmentObject var dbTicket: TicketVM
    @EnvironmentObject var randomId: RandomIdGenerator
    
    @State private var numOfTickets = 1
    
    var body: some View {
        List{
            ForEach(dbRide.rides, content: makeRideCellView)
            /* dbRide.rides , meaning the Foreach loop on every
            document in the collection */
            
            //then it will send the document to the function make cell
        }
        
        
    }
    
    
func makeRideCellView(_ ride:  Ride) -> some View {
    // an object of ride
        VStack{

            Text(ride.rideDropoff ?? "") // access to the rideDropoff attribute in ride object
            
            Text("\(ride.rideCapacity ?? 0)")
           
            HStack{
                Stepper("\(numOfTickets)", value: $numOfTickets, in: 1...10)
                Text("\(calculatePrice(ride, numOfTickets))")
                }
            Button{
                dbRide.decrementCapacity(ride, numOfTickets)
                dbTicket.issueTicket(ride, numOfTickets, calculatePrice(ride, numOfTickets), randomId.randomIds[0].number)
                randomId.incrementCounter()
            } label: {
                ZStack{
                    Rectangle()
                    Text("Book")
                }
            }
          
        }
    
    
    }
    
    func calculatePrice(_ ride:  Ride, _ numOfTickets : Int) -> Double{
        var price = (ride.ridePrice ?? 0)*(Double(numOfTickets))
        var newPrice = round(price * 100)/100.0
        return newPrice
        
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
