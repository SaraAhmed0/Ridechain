//
//  ContentView.swift
//  TicketBooking
//
//  Created by Sara AlMezeini on 08/01/2023.
//

import SwiftUI
import MapKit
struct SearchView: View {
    
    @StateObject var viewModel = RideViewModel()
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
                        if fromTF.isEmpty {
                            alertTitle = "No Arrival Entered"
                            alertMessage = "Please enter your Arrival"
                            showingAlert.toggle()
                        } else if toTF.isEmpty {
                            alertTitle = "No Destination Entered"
                            alertMessage = "Please enter your destination"
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
                            ForEach(viewModel.rides.indices, id: \.self){ index in
                                if  viewModel.rides[index].rideType == "Bus"{
                                    TodayCell(ride : viewModel.rides[index])
                                }
                            }
                            Spacer()
//                            SearchListView(isBusSelected: true, fromTF: $fromTF, toTF: $toTF)
//                                .environmentObject(viewModel)
//                                .environmentObject(dbTicket)
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
                            ForEach(viewModel.rides.indices, id: \.self){ index in
                                if  viewModel.rides[index].rideType == "Metro"{
                                    TodayCell(ride : viewModel.rides[index])
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
                SearchListView( fromTF: $fromTF, toTF: $toTF)
                    .environmentObject(viewModel)
                    .environmentObject(dbTicket)
                    .environmentObject(passengerVM)
            }
        }
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

