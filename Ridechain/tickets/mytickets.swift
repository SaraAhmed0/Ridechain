//
//  mytickets.swift
//  Ridechain
//
//  Created by Danah  on 27/12/2022.
//

import SwiftUI
import Foundation
struct mytickets: View {
    @EnvironmentObject var dbTicket : TicketVM
    

   
    @State var showSheetView = false
    @State var selected:Ticket?
    var body: some View {
        
        VStack{
            Text("Tickets").font(.custom("Roboto-Medium",size:44)).padding(.trailing, 200.0)
            Divider()
            Text("Coming Tickets").font(.custom("Roboto-Medium",size:20)).padding(.trailing, 200.0)
            ScrollView {
                
                ForEach( dbTicket.tickets,id:\.id)
                {ticket in
                    
                    Button(action:{ selected = Ticket(relatedRide: ticket.relatedRide, totaltickets: ticket.totaltickets, invoiceNo: ticket.invoiceNo, time :ticket.time, date :ticket.date, duration : ticket.duration, price :ticket.price,
                                                      dropoff : ticket.dropoff,
                                                      pickup : ticket.pickup,
                                                      type : ticket.type)})
                    {
                        maketicketinitv(ticket)
                        
                        
                        
                    }.sheet(item: $selected) {parameter in
                        
                        maketicketsheet(selected ?? Ticket()).presentationDetents([.medium])
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
                
            }
            
        }.background(colorp.slblue)
    }
    
        
        func maketicketinitv(_ ticket:  Ticket) -> some View {
           
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
                            Text(ticket.pickup ?? "" ).font(.custom("Roboto-Medium",size:16)).padding(.leading, 31.0)
                            Spacer()
                            
                            Text(ticket.dropoff ?? "").font(.custom("Roboto-Medium",size:16)).padding(.trailing,32.0)
                            
                        }.frame(height: 42.0)
                        
                        
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                            .frame(width:360, height: 1)
                        
                        
                        
                        
                        
                        
                        Spacer()
                            .frame(height: 22.0)
                        
                        
                        
                        HStack {
                            Label("Total Tickets", systemImage: "person.3").foregroundColor(colorp.lblue).padding(.leading, 15.0)
                            Spacer()
                            Label("Price", systemImage: "creditcard")
                                .padding(.trailing, 20).foregroundColor(colorp.lblue)
                        }.frame(height: 1).padding(.horizontal)
                        HStack{
                            Text("\(ticket.totaltickets ?? 0) Ticket").padding(.leading, 30.0)
                            Spacer()
                            Text(String(format: "%.2f", ticket.price ?? 0)).padding(.trailing,30)
                        }.padding()
                        
                    }.padding([.top, .leading, .trailing], 35.0)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    Circle().trim(from: 0, to: 0.5).foregroundColor(colorp.slblue)
                        .frame(width: 45.0, height: 46.0).rotationEffect(.degrees(-90)).padding(.trailing, 360.0)
                    
                    
                    
                    
                    
                    
                    Circle().trim(from: 0, to: 0.5).foregroundColor(colorp.slblue)                 .frame(width: 45.0, height: 46.0).rotationEffect(.degrees(-270)).padding(.leading, 360.0)
                    
                    
                    
                }.accentColor(.black)
            
            // changed the size to medium
//            {
//                let ticketsheet=maketicketsheet(ticket)
//            ticketsheet.presentationDetents([.height (642) ])
            }
            
        
    
    func maketicketsheet(_ eticket: Ticket) -> some View {


        VStack(alignment:.leading){
            Spacer()
                .frame(height: 205.0)
            ZStack{
                RoundedRectangle(cornerRadius: 10).foregroundColor(colorp.dgreen).frame(width: 96, height: 28)
                Text("valid").foregroundColor(.white)
            }
            Spacer()
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
                    Text(eticket.pickup ?? "").font(.custom("Roboto-Medium",size:16)).padding(.leading, 31.0)
                    Spacer()

                    Text(eticket.dropoff ?? "" ).font(.custom("Roboto-Medium",size:16)).padding(.trailing,32.0)

                }.frame(height: 42.0)

                HStack{
                    Text(eticket.date ?? Date(), style: .time).font(.custom("Roboto-Medium",size:16)).padding(.leading, 31.0)
                    Spacer()

                    Text(eticket.calculateDuration(eticket.date ?? Date(), duration: eticket.duration ?? 0), style: .time).font(.custom("Roboto-Medium",size:16)).padding(.trailing,32.0)

                }

                Spacer()
                    .frame(height: 44.0)

                HStack {
                    Label("Date", systemImage: "calendar").foregroundColor(colorp.lblue).padding(.leading, 15.0)
                    Spacer()
                    Label("Type", systemImage: "tram")
                        .padding(.trailing, 20).foregroundColor(colorp.lblue)
                }.frame(height: 1.0).padding(.horizontal)
                HStack{
                    Text(eticket.date ?? Date(), style: .date).padding(.leading, 30.0)
                    Spacer()
                    Text(eticket.type ?? "").padding(.trailing,30)
                }.padding()



                Spacer()
                    .frame(height: 44)



                HStack {
                    Label("Total Tickets", systemImage: "person.3").foregroundColor(colorp.lblue).padding(.leading, 15.0)
                    Spacer()
                    Label("Price", systemImage: "creditcard")
                        .padding(.trailing, 20).foregroundColor(colorp.lblue)
                }.frame(height: 1.0).padding(.horizontal)
                HStack{
                    Text("\(eticket.totaltickets ?? 0) Ticket").padding(.leading, 30.0)
                    Spacer()
                    Text(String(format: "%.2f", eticket.price ?? 0)).padding(.trailing,30)
                }.padding()




            }.padding()
            Divider().strikethrough()
            Spacer()
                .frame(width: 0.0, height: 150.0)
        }.padding()

    }
    
    

       
    }



    


struct choosetickets_Previews: PreviewProvider {
    static var previews: some View {
      
            
            
            mytickets()
        
        
        
        }
    }
