//
//  editSheet.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 22/07/1444 AH.
//

import SwiftUI

struct editSheet: View {
    @State var pickup = ""
    @State var dropoff = ""
    @State var date = Date()
    @State var time = Date()
    @State var duration = ""
    @State var type = ""
    @State var capacity = ""
    @State var price = ""
    var ride: Ride
    @EnvironmentObject var dbRide: RideVM
    @Binding var showEditSheetView: Bool
    
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(colorp.slblue).ignoresSafeArea()
            
            VStack{
                //        Text(ride.rideDropoff ?? "")
                Form{
                    Section{
                        HStack{
                            Image(systemName: "arrow.right").foregroundColor(colorp.dblue)
                            TextField( "From", text: $pickup )
                        }
                        HStack{
                            Image(systemName: "arrow.backward").foregroundColor(colorp.dblue)
                            TextField( "To", text: $dropoff )
                        }
                    }
                    Section{
                        HStack{
                            Image(systemName: "calendar").foregroundColor(colorp.dblue)
                            DatePicker("Date", selection: $date, displayedComponents: [.date])
                        }
                        HStack{
                            Image(systemName: "clock").foregroundColor(colorp.dblue)
                            DatePicker("At", selection: $time, displayedComponents: [.hourAndMinute])
                        }
                        HStack{
                            Image(systemName: "clock.arrow.circlepath").foregroundColor(colorp.dblue)
                            TextField( "Duration", text: $duration )
                        }
                    }
                    Section{
                        HStack{
                            Image(systemName:type == "Metro" ? "tram.fill" : "bus.fill").foregroundColor(colorp.dblue)
                            TextField( "Type", text: $type)
                        }
                        HStack{
                            Image(systemName: "person.3").foregroundColor(colorp.dblue)
                            TextField( "Availabilty", text: $capacity )
                        }
                        
                    }
                    Section{
                        Image(systemName: "creditcard").foregroundColor(colorp.dblue)
                        TextField( "Price", text: $price )
                    }
                    
                }
                Button{
                    ride.rideStartTime = time
                    ride.rideDate = date
                    ride.rideType = type
                    ride.ridePrice = Double(price)
                    ride.rideCapacity = Int(capacity)
                    ride.ridePickup = pickup
                    ride.rideDropoff = dropoff
                    ride.rideDuration = Int(duration)
                    
                    dbRide.updateRide(ride)
                    
                    showEditSheetView = false
                    
                }label: {
                    ZStack{
                        Rectangle()
                            .fill(colorp.lgreen)
                            .frame(width: 362, height: 40)
                        Text("Save").foregroundColor(.white)
                        
                    }
                }
            }
        }
    }
}


