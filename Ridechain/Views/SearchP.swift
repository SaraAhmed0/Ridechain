//
//  SearchP.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 29/07/1444 AH.
//

import SwiftUI
import MapKit

struct SearchP: View {
    @StateObject var viewModel = RideViewModel()
    @EnvironmentObject var dbRide: RideVM
    @EnvironmentObject var dbTicket: TicketVM
    @EnvironmentObject var passengerVM: PassengerVM
    @State var isShowingTicketsView = false
    @State var isShowingSearchView = false
    @State var fromTF: String = ""
    @State var toTF: String = ""
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State private var showingAlert = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottom){
                Map(coordinateRegion: $region)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Spacer()
                    //Rectangle 17
                    RoundedRectangle(cornerRadius: 27)
                        .fill(Color.seaGreen)
                        .frame(height: 555)
                    
                }.edgesIgnoringSafeArea(.bottom)
                
                VStack(alignment: .leading,spacing: 20) {
                    //Where Are You Headed Today?
                    Text("Where Are You Headed Today?")
                        .scaledFont(name: .regular, size: 24)
                        .foregroundColor(Color.lightGreen)
                    
                    ZStack{
                        //Rectangle 18
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .frame(height: 43)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.parrotColor)
                            TextField("From", text: $fromTF)
                                .foregroundColor(Color.gray)
                                .scaledFont(name: .regular, size: 18)
                        }.padding()
                    }
                    
                    ZStack{
                        //Rectangle 18
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .frame(height: 43)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.parrotColor)
                            TextField("To", text: $toTF)
                                .foregroundColor(Color.gray)
                                .scaledFont(name: .regular, size: 18)
                        }.padding()
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.parrotColor)
                            .frame(height: 43)
                        
                        Text("Search")
                            .foregroundColor(.white)
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        
                    }.onTapGesture {
                        if fromTF.isEmpty || toTF.isEmpty {
                            alertTitle = "Missing Information"
                            alertMessage = "Please enter your destenation"
                            showingAlert.toggle()
                        } else {
                            isShowingSearchView.toggle()
                        }
                    }
                    
                    //Or look by type
                    Text("Or look by type ")
                        .scaledFont(name: .regular, size: 24)
                        .foregroundColor(Color.lightGreen)
                    
                    
                    HStack{
                        //Bus
                        
                        NavigationLink {
                            ForEach(dbRide.rides.indices, id: \.self){ index in
                                if  dbRide.rides[index].rideType == "Bus"{
                                    SearchListCellView(ride : dbRide.rides[index])
                                }
                            }
                            Spacer()
                        } label: {
                            VStack(spacing: 10){
                                Text("Bus")
                                    .scaledFont(name: .regular, size: 18)
                                    .foregroundColor(Color.white)
                                
                                Image(systemName: "bus")
                                    .foregroundColor(Color.white)
                                
                            }.frame(height: 82)
                                .frame(maxWidth: .infinity)
                        }
                        .tint(.darkGreen)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle)
                        .controlSize(.large)
                        
                        NavigationLink {
                            ForEach(dbRide.rides.indices, id: \.self){ index in
                                if  dbRide.rides[index].rideType == "Metro"{
                                    SearchListCellView(ride : dbRide.rides[index])
                                }
                            }
                            Spacer()
                        } label: {
                            VStack(spacing: 10){
                                Text("Metro")
                                    .scaledFont(name: .regular, size: 18)
                                    .foregroundColor(Color.white)
                                
                                Image(systemName: "tram")
                                    .foregroundColor(Color.white)
                                
                            }.frame(height: 82)
                                .frame(maxWidth: .infinity)
                        }
                        .tint(.darkGreen)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle)
                        .controlSize(.large)
                        
                    }
                    
                }.padding(.horizontal, 24)
                    .padding(.bottom, 30)
            }
            .navigationDestination(isPresented: $isShowingSearchView) {
                ForEach(dbRide.rides.indices, id: \.self){ index in
                    if  (fromTF.range(of: dbRide.rides[index].ridePickup ?? "", options: .caseInsensitive) != nil) && (toTF.range(of: dbRide.rides[index].rideDropoff ?? "", options: .caseInsensitive) != nil){

                        SearchListCellView(ride : dbRide.rides[index])
                    }
                }
                Spacer()

            }
        }
    }
}

struct SearchP_Previews: PreviewProvider {
    static var previews: some View {
        SearchP()
    }
}
