//
//  SearchListCellView.swift
//  TicketBooking
//
//  Created by Sara AlMezeini on 08/01/2023.
//

import SwiftUI

struct SearchListCellView: View {
    @State var presentSheet = false
    @EnvironmentObject var dbTicket: TicketVM
    @EnvironmentObject var passengerVM: PassengerVM
    var ride: Ride
    var body: some View {
        //Rectangle 9
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)

            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.parrotColor.opacity(0.4), lineWidth: 1)
            
            VStack(spacing: 10){
            
                HStack{
                    Text(ride.rideStartTime?.getTime() ?? "")
                        .scaledFont(name: .medium, size: 16)
                        .foregroundColor(.black)
                    
                    Image("dottedLine")
                        .offset(y: 4)
                    
                    Image(systemName: ride.rideType == "Bus" ? "bus" : "tram")
                        .foregroundColor(.lightGreen)
                    
                    Image("dottedLineRight")
                        .offset(y: 4)
                    
                    Text(ride.rideStartTime?.adding(minutes: ride.rideDuration ?? 0) ?? "")
                        .scaledFont(name: .medium, size: 16)
                        .foregroundColor(.black)
                }
                
                Text("\(ride.rideDuration?.description ?? "0")min")
                    .scaledFont(name: .medium, size: 16)
                    .foregroundColor(.lightGreen)
                
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

//struct SearchListCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchListCellView(ticket: ride.ridedemoTicket)
//    }
//}
extension Date{
    func getTime(date: Date? = nil) -> String {
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "hh:mm aa"

        // Convert Date to String
        return dateFormatter.string(from: date ?? self)
    }
    
    func getFormatted() -> String {
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"

        // Convert Date to String
        return dateFormatter.string(from: self)
    }
    
    func adding(minutes: Int) -> String {
        let addedDate = Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
        return getTime(date: addedDate)
    }
}
