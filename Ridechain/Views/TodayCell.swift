//
//  TodayCell.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 29/07/1444 AH.
//

import SwiftUI

struct TodayCell: View {
    @State var presentSheet = false
    @EnvironmentObject var dbTicket: TicketVM
    @EnvironmentObject var passengerVM: PassengerVM
    var ride: Ride
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)

            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.parrotColor.opacity(0.4), lineWidth: 1)
            
            VStack(spacing: 10){
//                HStack{
//                    Text(ride.rideStartTime?.getTime() ?? "")
//                        .scaledFont(name: .medium, size: 16)
//                        .foregroundColor(.black)
//
//                    Image("dottedLine")
//                        .offset(y: 4)
//
//                    Image(systemName: ride.rideType == "Bus" ? "bus.fill" : "tram.fill")
//                        .foregroundColor(.lightGreen)
//
//                    Image("dottedLineRight")
//                        .offset(y: 4)
//
//                    Text(ride.rideStartTime?.adding(minutes: ride.rideDuration ?? 0) ?? "")
//                        .scaledFont(name: .medium, size: 16)
//                        .foregroundColor(.black)
//                }
                HStack{
                    
                    
                    Text("From").font(.custom("Roboto-Medium",size:16)).padding(.leading, 30).foregroundColor(colorp.lblue)
                    
                    
                    
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
                HStack{
                    Text(ride.ridePickup ?? "").font(.custom("Roboto-Medium",size:16)).padding(.leading, 31.0)
                    Spacer()
                    Text("\(ride.rideDuration?.description ?? "0")min").foregroundColor(colorp.lblue)
                    Spacer()
                    Text(ride.rideDropoff ?? "").font(.custom("Roboto-Medium",size:16)).padding(.trailing,32.0)
                    
                }
                
//                Text("\(ride.rideDuration?.description ?? "0")min")
//                    .scaledFont(name: .medium, size: 16)
//                    .foregroundColor(.lightGreen)
                
                Text(ride.rideDate?.formatted() ?? "")
                    .scaledFont(name: .medium, size: 16)
                    .foregroundColor(.lightGreen)
                    
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
                .environmentObject(passengerVM)
                .presentationDetents([.fraction(0.5)])
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            
        }
    }
}

//struct TodayCell_Previews: PreviewProvider {
//    static var previews: some View {
//        TodayCell()
//    }
//}
