//
//  Today.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 09/07/1444 AH.
//

import SwiftUI

struct Today: View {
    @EnvironmentObject var dbRide: RideVM
    @EnvironmentObject var dbTicket: TicketVM
    @State var presentSheet = false
    
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(colorp.slblue).ignoresSafeArea()
            VStack{
                ZStack{
                    Rectangle()
                        .fill(Color.darkGreen)
                        .frame(height: 84)
                    
                    
                    HStack{
                        Image(systemName: "location")
                            .foregroundColor(.parrotColor)
                        Image("verticalDottedLine")
                        Text("Riyadh")
                        
                        
                        //                    VStack{
                        //
                        //                        HStack{
                        //
                        //                            VStack(spacing: 12){
                        //                                Text("From")
                        //                                    .scaledFont(name: .medium, size: 16)
                        //                                    .foregroundColor(.white)
                        //                                Text(pickup ?? "")
                        //                                    .scaledFont(name: .medium, size: 16)
                        //                                    .foregroundColor(.white)
                        //                            }
                        //
                        //                            HStack(spacing: -8){
                        //                                Image("dottedLine")
                        //                                Image("dottedLineRight")
                        //                            }.offset(y: -8)
                        //
                        //                            VStack(spacing: 12){
                        //                                Text("To")
                        //                                    .scaledFont(name: .medium, size: 16)
                        //                                    .foregroundColor(.white)
                        //                                Text(dropOff ?? "")
                        //                                    .scaledFont(name: .medium, size: 16)
                        //                                    .foregroundColor(.white)
                        //                            }
                        //                        }
                        //
                        //                    }
                        
                    }
                }
                VStack{
                    ForEach(dbRide.rides, content: makeRideCell)
                }
                
            }
        }
    }
    
    func makeRideCell (_ ride : Ride) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)

            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.parrotColor.opacity(0.4), lineWidth: 1)
            
            VStack(spacing: 10){
            
                HStack{
                    Text("From").font(.custom("Roboto-Medium",size:16)).padding(.leading, 30).foregroundColor(colorp.lblue)
//                    Text(ride.rideStartTime?.getTime() ?? "")
//                        .scaledFont(name: .medium, size: 16)
//                        .foregroundColor(.black)
                    
                    Image("dottedLine")
                        .offset(y: 4)
                    
                    Image(systemName: ride.rideType == "Bus" ? "bus" : "tram")
                        .foregroundColor(.lightGreen)
                    
                    Image("dottedLineRight")
                        .offset(y: 4)
                    
                    Text("To").font(.custom("Roboto-Medium",size:16)).padding(.leading, 30).foregroundColor(colorp.lblue)
                    
//                    Text(ride.rideStartTime?.adding(minutes: ride.rideDuration ?? 0) ?? "")
//                        .scaledFont(name: .medium, size: 16)
//                        .foregroundColor(.black)
                }
                
                HStack{
                    Text(ride.ridePickup ?? "").font(.custom("Roboto-Medium",size:16)).padding(.leading, 30)
                    
                    Text("\(ride.rideDuration?.description ?? "0")min")
                        .scaledFont(name: .medium, size: 16)
                        .foregroundColor(.lightGreen)
                    
                    Text(ride.rideDropoff ?? "").font(.custom("Roboto-Medium",size:16)).padding(.leading, 30)
                }
                
//                Text("\(ride.rideDuration?.description ?? "0")min")
//                    .scaledFont(name: .medium, size: 16)
//                    .foregroundColor(.lightGreen)
//
//                Text(ride.rideDate?.formatted() ?? "")
//                    .scaledFont(name: .medium, size: 16)
//                    .foregroundColor(.lightGreen)
                    
            }
        }
        .frame(height: 110)
        .padding(.horizontal, 20)
        .onTapGesture {
            presentSheet.toggle()
        }
        .sheet(isPresented: $presentSheet) {
            BookTicketSheetView(ride: ride)
                .environmentObject(dbTicket)
                .presentationDetents([.fraction(0.5)])
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            
        }
    }
}

struct Today_Previews: PreviewProvider {
    static var previews: some View {
        Today()
    }
}
