//
//  ridesheet.swift
//  ServiceProvider
//
//  Created by Danah  on 30/01/2023.
//

import SwiftUI

struct ridesheet: View {
    @State var showEditSheetView = false
    var ride : Ride
    let dateFormatter = DateFormatter()
    var dateFormatter2 = DateFormatter()
    @EnvironmentObject var dbRide: RideVM
//    @State var showCreateSheet = false
    
    var body: some View {   VStack(alignment:.leading){
        
        
        VStack{
            
            HStack{
                
                
                Text("From").font(.custom("Roboto-Medium",size:14)).padding(.leading, 30).foregroundColor(colorp.lblue)
                
                
                
                ZStack{
                    Circle()
                        .fill(.black).shadow(radius: 100)
                        .frame(width: 15.0, height: 5.0).padding(.trailing, 70.0)
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                    .frame(width: 66, height: 1)}
                
                Image(systemName:ride.rideType == "Metro" ? "tram.fill" : "bus.fill").foregroundColor(colorp.lblue)
                    .padding(.horizontal, -13.0)
                ZStack{
                    Circle()
                        .fill(.black).shadow(radius: 100)
                        .frame(width: 15.0, height: 5.0).padding(.leading, 60.0)
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                    .frame(width: 66, height: 1)}
                
                
                Text("To").font(.custom("Roboto-Medium",size:16)).padding(.trailing, 50).foregroundColor(colorp.lblue)
                
                
                
                
            }
            
            .frame(height: 0.0)
            
            HStack{
                Text(ride.ridePickup ?? "").font(.custom("Roboto-Medium",size:16)).padding(.leading, 31.0)
                Spacer()
                
                Text(ride.rideDropoff ?? "").font(.custom("Roboto-Medium",size:16)).padding(.trailing,32.0)
                
            }.frame(height: 42.0)
            
            HStack{
                Text(ride.rideStartTime ?? Date(), style: .time).font(.custom("Roboto-Medium",size:16)).padding(.leading, 31.0)
                Spacer()
                
                Text(ride.calculateDuration(ride.rideStartTime ?? Date(), duration: ride.rideDuration ?? 0), style: .time).font(.custom("Roboto-Medium",size:16)).padding(.trailing,32.0)
                
            }
            
            Spacer()
                .frame(height: 44.0)
           
            HStack {
                Label("Date", systemImage: "calendar").foregroundColor(colorp.lblue).padding(.leading, 15.0)
                Spacer()
                Label("Type", systemImage: ride.rideType == "Metro" ? "tram.fill" : "bus.fill")
                    .padding(.trailing, 20).foregroundColor(colorp.lblue)
            }.frame(height: -1.0).padding(.horizontal)
            HStack{
                Text(ride.rideDate ?? Date(), style: .date).padding(.leading, 30.0)
                Spacer()
                Text(ride.rideType ?? "").padding(.trailing,30)
            }.padding()
            
            
            
            
            Spacer()
                .frame(height: 44)
            
            
            
            HStack {
                Label("Avalability", systemImage: "person.3").foregroundColor(colorp.lblue).padding(.leading, 15.0)
                Spacer()
                Label("Price", systemImage: "ticket")
                    .padding(.trailing, 20).foregroundColor(colorp.lblue)
            }.frame(height: -1.0).padding(.horizontal)
            HStack{
                Text("\(ride.rideCapacity ?? 0) Seats").padding(.leading, 30.0)
                Spacer()
                Text(String(format: "%.2f", ride.ridePrice ?? 0)).padding(.trailing,30)
            }.padding()
            
            
            
            
        }.padding()
        Divider().strikethrough()
        Spacer()
            .frame( height: 20.0)
 HStack{
     Button(action:{self.showEditSheetView.toggle()}){
     ZStack{
         Rectangle()
             .fill(colorp.lgreen)
             .frame(width: 166, height: 40)
         Text("Edit").foregroundColor(.white)
         
     }}
     .sheet(isPresented: $showEditSheetView) {
         editSheet(pickup : ride.ridePickup ?? "",dropoff : ride.rideDropoff ?? "",
                   date : ride.rideDate ?? Date(),
                   time : ride.rideDate ?? Date(),
                   duration : String(ride.rideDuration ?? 0),
                   type : ride.rideType ?? "",
                   capacity : String(ride.rideCapacity ?? 0),
                   price : String(ride.ridePrice ?? 0.0), ride : ride, showEditSheetView: $showEditSheetView)
     }
         
     Button(action:{
         dbRide.deleteRide(ride)
     }){
         ZStack{
             Rectangle()
                 .fill(colorp.slblue)
                 .frame(width: 166, height: 40)
             Text("Delete").foregroundColor(colorp.lgreen)
             
         }}
         
         
     }
    }.padding()
    }
}

