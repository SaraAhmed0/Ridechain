//
//  ticketinitv.swift
//  Ridechain
//
//  Created by Danah  on 27/12/2022.
//


import SwiftUI

struct ticketinitv: View {
    let nticket:ticket
    @EnvironmentObject var dbTicket: TicketVM
    @State var showSheetView = false
    var body: some View {
       
        Button(action:{  self.showSheetView.toggle()}){
            
            
            
            
            ZStack{
                RoundedRectangle(cornerRadius: 25).fill(.white).frame(width: 357.0, height: 157.0)
                
                
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
                        Text(nticket.pickup ).font(.custom("Roboto-Medium",size:16)).padding(.leading, 31.0)
                        Spacer()
                        
                        Text(nticket.destnation).font(.custom("Roboto-Medium",size:16)).padding(.trailing,32.0)
                        
                    }.frame(height: 42.0)
                    
                    
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                        .frame(width:360, height: 1)
                    
                    
                    
                    
                    
                    
                    Spacer()
                        .frame(height: 22.0)
                    
                    
                    
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
                    
                }.padding([.top, .leading, .trailing], 35.0)
                
                
                
                
                
                
                
                
                
                
                Circle().trim(from: 0, to: 0.5).foregroundColor(colorp.slblue)
                    .frame(width: 45.0, height: 46.0).rotationEffect(.degrees(-90)).padding(.trailing, 360.0)
                
                
                
                
                
                
                Circle().trim(from: 0, to: 0.5).foregroundColor(colorp.slblue)                 .frame(width: 45.0, height: 46.0).rotationEffect(.degrees(-270)).padding(.leading, 360.0)
                
                
                
            } .accentColor(.black)
        
        }
        .sheet(isPresented: $showSheetView) {
            ticketv(nticket: nticket) .presentationDetents([.height (642) ])
        }
        
        
        }
    }


struct ticketinitv_Previews: PreviewProvider {
    static var nticket = ticket.sampledata[0]
    static var previews: some View {
        ticketinitv(nticket: nticket).background(colorp.slblue).previewLayout(.fixed(width: 400, height: 60))
    }}

