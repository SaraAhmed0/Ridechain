//
//  addRide.swift
//  ServiceProvider
//
//  Created by Danah  on 30/01/2023.
//

import SwiftUI

struct addRide: View {
    @State private var pickup: String = ""
    @State private var dropoff: String = ""
    @State private var date = Date()
    @State private var time = Date()
    @State private var duration = ""
    @State private var type = ""
    @State private var capacity = ""
    @State private var price = ""
    @EnvironmentObject var dbRide: RideVM
    @State private var showSaveAlert = false
    @State var goTo = false
    var body: some View {
        VStack{
            VStack(alignment:.leading){
                Text("Add Ride").font(.custom("Roboto-Medium",size:44))
                Divider()
                Text("Destenation and Time").foregroundColor(.gray)
                    .font(.subheadline)
                HStack{
                    Image(systemName: "arrow.right").foregroundColor(colorp.dblue)
                    TextField("From", text: $pickup).frame(width: 330.0, height: 40.0)
                }.background(.white)
                HStack{
                    Image(systemName: "arrow.backward").foregroundColor(colorp.dblue)
                    TextField("To  ", text: $dropoff).frame(width: 330.0, height: 40.0)
                }.background(.white)
                Spacer()
                    .frame(height: 30.0)
                Text("Date and Duration").foregroundColor(.gray)
                    .font(.subheadline)
                HStack{
                    Image(systemName: "calendar").foregroundColor(colorp.dblue)
                    ZStack{
                        Rectangle()
                            .fill(.white)
                            .frame(width: 333, height: 40)
                        DatePicker("label", selection: $date, displayedComponents: [.date])
                            .padding(.trailing, 200.0)
                            .datePickerStyle(CompactDatePickerStyle())
                            .labelsHidden()
                    
                       
                    }
                   
                    }.background(.white)
                HStack{
                    Image(systemName: "clock").foregroundColor(colorp.dblue)
                    ZStack{
                        Rectangle()
                            .fill(.white)
                            .frame(width: 333, height: 40)
                        DatePicker("label", selection: $time, displayedComponents: [.hourAndMinute])
                            .padding(.trailing, 200.0)
                            .datePickerStyle(CompactDatePickerStyle())
                            .labelsHidden()
                    
                       
                    }
                   
                    }.background(.white)
                
                HStack{
                    Image(systemName: "clock.arrow.circlepath").foregroundColor(colorp.dblue)
                    TextField("Duration", text: $duration).frame(width: 330.0, height: 40.0)
                }.background(.white)
                
               
            }
            
            
            
            VStack(alignment:.leading){
                
                Spacer()
                    .frame(height: 30.0)
                Text("Type and Availability").foregroundColor(.gray)
                    .font(.subheadline)
                HStack{
                    Image(systemName: "tram").foregroundColor(colorp.dblue)
                    TextField("Type", text: $type).frame(width: 330.0, height: 40.0)
                }.background(.white)
                HStack{
                    Image(systemName: "person.3").foregroundColor(colorp.dblue)
                    TextField("Availability", text: $capacity).frame(width: 314.0, height: 40.0)
                }.background(.white)
                
               
                Spacer()
                    .frame(height: 30.0)
                Text("Price").foregroundColor(.gray)
                    .font(.subheadline)
                HStack{
                    Image(systemName: "creditcard").foregroundColor(colorp.dblue)
                    TextField("Price", text: $price).frame(width: 330.0, height: 40.0)
                }.background(.white)
               
                
            }
            Spacer()
                .frame(height: 50.0)
            VStack{
                Button(action:{
                    if pickup != ""{
                        dbRide.addRide(Ride(rideStartTime: time, rideDate: date, rideType: type, ridePrice: Double(price), rideCapacity: Int(capacity), ridePickup: pickup, rideDropoff: dropoff, rideDuration: Int(duration)))
                        goTo = true
                        
                    }
                }){
                    ZStack{
                        Rectangle()
                            .fill(colorp.lgreen)
                            .frame(width: 362, height: 40)
                        Text("Save").foregroundColor(.white)
                       
                    }
                }.alert( isPresented: $showSaveAlert) {
                    
                    Alert(
                        title: Text("Ride Added Succecfully"),
                        message: Text(""),
                        primaryButton: .destructive(Text("Delete"), action: {
                    
                        }),
                        secondaryButton: .cancel(Text(""), action: { // 1
                            
                            
                        })
                    )
                    
                }
            }
            
            
//            NavigationLink(destination: UserType(), isActive: $showSheet) {
//                           EmptyView()
//                         }
            
        }.padding().background(colorp.slblue).ignoresSafeArea()
 

    }
}

struct addRide_Previews: PreviewProvider {
    static var previews: some View {
        addRide()
    }
}
