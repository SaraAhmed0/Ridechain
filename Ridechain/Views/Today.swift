//
//  Today.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 09/07/1444 AH.
//

import SwiftUI

struct Today: View {
    @State var showBookTicketSheet = false
    @State var showTicketPopupView = false
    @EnvironmentObject var dbRide: RideVM
    @EnvironmentObject var dbTicket: TicketVM
    @EnvironmentObject var dbPassenger: PassengerVM
    @State var isShowingTicketsView = false
    @State var isShowingSearchView = false
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
                        
                    }.onTapGesture {
                        showBookTicketSheet.toggle()
                    }
                }
                ScrollView{
                   
                    ForEach(dbRide.rides){ ride in
                        if checktime(ride){
                            SearchListCellView(ride: ride)
                                .environmentObject(dbTicket)
                                .environmentObject(dbPassenger)
                        }
                    }
                    
                }
            }
            .navigationTitle("Search")
            .sheet(isPresented: $showBookTicketSheet) {
                BillSheetView()
                    .environmentObject(dbTicket)
                    .environmentObject(dbPassenger)
                    .presentationDetents([.fraction(0.7)])
                    .presentationDragIndicator(.visible)
                
            }
            if showTicketPopupView{
                TicketBookedPopupSuccessView(showTicketPopupView: $showTicketPopupView)
            }
        }.onAppear(){
            NotificationCenter.default.addObserver(forName: Notification.didBookTicket, object: nil, queue: .main) { (_) in
                
                showTicketPopupView.toggle()
            }
            NotificationCenter.default.addObserver(forName: Notification.viewTicket, object: nil, queue: .main) { (_) in
                
                showBookTicketSheet.toggle()
            }
            
        }
       
    }
    func checktime(_ ride :Ride)-> Bool
    {
        let date2 = ride.rideDate ?? Date()
        let istoday = Calendar.current.isDateInToday(date2)
        
        if   istoday {
            return true
        }
        else
        {
            return false
        }
    
    }
}

struct Today_Previews: PreviewProvider {
    static var previews: some View {
        Today()
    }
}
