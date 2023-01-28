//
//  ContentView.swift
//  TicketBooking
//
//  Created by Jawaher on 08/01/2023.
//

import SwiftUI
import MapKit
struct ContentView: View {
    
    @StateObject var viewModel = RideViewModel()
    @EnvironmentObject var dbTicket: TicketVM
    @State var isShowingTicketsView = false
    @State var fromTF: String = ""
    @State var toTF: String = ""
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View {
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
                
                NavigationLink {
                    SearchListView(pickup: fromTF, dropOff: toTF)
                        .environmentObject(viewModel)
                        .environmentObject(dbTicket)
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.parrotColor)
                            .frame(height: 43)
                        
                        Text("Search")
                            .foregroundColor(.white)
                    }
                }
                
                //Or look by type
                Text("Or look by type ")
                    .scaledFont(name: .regular, size: 24)
                    .foregroundColor(Color.lightGreen)
                
                
                HStack{
                    //Bus
                    NavigationLink {
                        SearchListView(isBusSelected: true)
                            .environmentObject(viewModel)
                            .environmentObject(dbTicket)
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
                        SearchListView(isBusSelected: false)
                            .environmentObject(viewModel)
                            .environmentObject(dbTicket)
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
                .padding(.bottom, 70)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
