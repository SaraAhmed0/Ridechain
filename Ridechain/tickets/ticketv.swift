//
//  ticketv.swift
//  Ridechain
//
//  Created by Danah  on 27/12/2022.
//

import SwiftUI

struct ticketv: View {
    let nticket:ticket 
    var body: some View {
        VStack(alignment:.leading){
            ZStack{
                RoundedRectangle(cornerRadius: 10).foregroundColor(colorp.dgreen).frame(width: 96, height: 28)
                Text("valid").foregroundColor(.white)
            }
            Text("Sara Ahmed").font(.custom("Roboto-Medium",size:32)).fontWeight(.bold)
            
            Text("Show this ticket at the entrance").font(.custom("Roboto-Medium",size:16)).fontWeight(.regular).foregroundColor(.gray)
            Divider()
            
            
            
       
            VStack{
                
                HStack{
                    
                    
                    Text("From").font(.custom("Roboto-Medium",size:16)).padding(.leading, 30).foregroundColor(colorp.lblue)
                    
                    
                    
                    ZStack{
                        Circle()
                            .fill(.black).shadow(radius: 100)
                            .frame(width: 15.0, height: 5.0).padding(.trailing, 70.0)
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                        .frame(width: 66, height: 1)}
                    
                    Image(systemName:"bus.doubledecker.fill").foregroundColor(colorp.lblue)
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
                    Text(nticket.pickup).font(.custom("Roboto-Medium",size:16)).padding(.leading, 31.0)
                    Spacer()
                    
                    Text(nticket.destnation).font(.custom("Roboto-Medium",size:16)).padding(.trailing,32.0)
                    
                }.frame(height: 42.0)
                
                HStack{
                    Text("10:00 am").font(.custom("Roboto-Medium",size:16)).padding(.leading, 31.0)
                    Spacer()
                    
                    Text("10:10 am").font(.custom("Roboto-Medium",size:16)).padding(.trailing,32.0)
                    
                }
                
                Spacer()
                    .frame(height: 44.0)
               
                HStack {
                    Label("Date", systemImage: "calendar").foregroundColor(colorp.lblue).padding(.leading, 15.0)
                    Spacer()
                    Label("Type", systemImage: "tram")
                        .padding(.trailing, 20).foregroundColor(colorp.lblue)
                }.frame(height: -1.0).padding(.horizontal)
                HStack{
                    Text("Sunday, 2/3/2023").padding(.leading, 30.0)
                    Spacer()
                    Text("metro").padding(.trailing,30)
                }.padding()
                
                
                
                
                Spacer()
                    .frame(height: 44)
                
                
                
                HStack {
                    Label("Total Tickets", systemImage: "person.3").foregroundColor(colorp.lblue).padding(.leading, 15.0)
                    Spacer()
                    Label("Price", systemImage: "clock")
                        .padding(.trailing, 20).foregroundColor(colorp.lblue)
                }.frame(height: -1.0).padding(.horizontal)
                HStack{
                    Text("1 Ticket").padding(.leading, 30.0)
                    Spacer()
                    Text("25").padding(.trailing,30)
                }.padding()
                
                
                
                
            }.padding()
            Divider().strikethrough()
            Spacer()
                .frame(width: 0.0, height: 150.0)
        }.padding()
       
    }
}

struct ticketv_Previews: PreviewProvider {
    static var nticket = ticket.sampledata[0]
    static var previews: some View {
        ticketv(nticket: nticket)
    }
}
