//
//  SearchListView.swift
//  TicketBooking
//
//  Created by Sara AlMezeini on 08/01/2023.
//

import SwiftUI
import Swift

struct SearchListView: View {
    
    @State var showBookTicketSheet = false
    @State var showTicketPopupView = false
    @State var rides = [Ride]()
    let newRides = [Ride]()
    @EnvironmentObject var dbTicket: TicketVM
    @EnvironmentObject var viewModel: RideViewModel
    @EnvironmentObject var passengerVM: PassengerVM
    var pickup: String? = nil
    var dropOff: String? = nil
//    var isBusSelected: Bool? = nil
    @Binding var fromTF: String
    @Binding var toTF: String
    
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(Color.darkGreen)
                        .frame(height: 84)
                    
                    
                    HStack{
                        Image(systemName: "location")
                            .foregroundColor(.parrotColor)
                        Image("verticalDottedLine")
                        
                        VStack{
                            
                            HStack{
                                
                                VStack(spacing: 12){
                                    Text("From")
                                        .scaledFont(name: .medium, size: 16)
                                        .foregroundColor(.white)
                                    Text(fromTF ?? "")
                                        .scaledFont(name: .medium, size: 16)
                                        .foregroundColor(.white)
                                }
                                
                                HStack(spacing: -8){
                                    Image("dottedLine")
                                    Image("dottedLineRight")
                                }.offset(y: -8)
                                
                                VStack(spacing: 12){
                                    Text("To")
                                        .scaledFont(name: .medium, size: 16)
                                        .foregroundColor(.white)
                                    Text(toTF ?? "")
                                        .scaledFont(name: .medium, size: 16)
                                        .foregroundColor(.white)
                                }
                            }
                            
                        }
                        
                    }.onTapGesture {
                        showBookTicketSheet.toggle()
                    }
                }
                ScrollView{
//                    if newRide(rides) > 0 {
                        ForEach(rides){ ride in
                            if  (fromTF.range(of: ride.ridePickup ?? "", options: .caseInsensitive) != nil) && (toTF.range(of: ride.rideDropoff ?? "", options: .caseInsensitive) != nil) {
                                SearchListCellView(ride: ride)
                                    .environmentObject(dbTicket)
                                    .environmentObject(passengerVM)
                            }
                        }
                       
//                    }else {
//                        notFound()
//                    }
                }
            }
            .navigationTitle("Search")
            .sheet(isPresented: $showBookTicketSheet) {
                BillSheetView()
                    .environmentObject(dbTicket)
                    .environmentObject(passengerVM)
                    .presentationDetents([.fraction(0.7)])
                    .presentationDragIndicator(.visible)
                
            }
            if showTicketPopupView{
                TicketBookedPopupSuccessView(showTicketPopupView: $showTicketPopupView)
            }
        }
        .onAppear(){
//            if let isBusSelected {
//                self.rides = viewModel.rides.filter({(isBusSelected ? $0.rideType == "Bus" : $0.rideType == "Metro")})
//            }else{
//                self.rides = viewModel.rides.filter({($0.ridePickup?.localizedCaseInsensitiveContains(pickup ?? "") ?? false) && ($0.rideDropoff?.localizedCaseInsensitiveContains(dropOff ?? "") ?? false)})
//            }
            
            NotificationCenter.default.addObserver(forName: Notification.didBookTicket, object: nil, queue: .main) { (_) in
                
                showTicketPopupView.toggle()
            }
            NotificationCenter.default.addObserver(forName: Notification.viewTicket, object: nil, queue: .main) { (_) in
                
                showBookTicketSheet.toggle()
            }
        }
        
        
    }
    func newRide(_ rides : [Ride]) -> Int{
        var counter = 0
        for ride in rides{
            if  (fromTF.range(of: ride.ridePickup ?? "", options: .caseInsensitive) != nil) && (toTF.range(of: ride.rideDropoff ?? "", options: .caseInsensitive) != nil) {
                counter = counter + 1
            }
        }
        return counter
    }
    
}

struct notFound : View{
    var body: some View {
        VStack{
            Text("Search not found")
                .scaledFont(name: .medium, size: 26).padding()
            
            Text("Your destenation is not found please try again")
                .scaledFont(name: .medium, size: 20)
                .multilineTextAlignment(.center)
        }
    }
}


//struct SearchListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchListView()
//    }
//}
