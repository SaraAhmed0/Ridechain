//
//  BillSheetView.swift
//  TicketBooking
//
//  Created by Jawaher on 09/01/2023.
//

import SwiftUI

struct BillSheetView: View {
    @EnvironmentObject var dbTicket: TicketVM
    @State var presentSheet = false
    var body: some View {
        
        NavigationView {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .frame(height: 624)
                if let ticket = dbTicket.bookedTicket{
                    VStack(alignment:.leading) {
                        
                        Button(action: {
                            print("validate")
                            presentSheet = true
                        }, label: {
                            Text("Valid")
                                .padding(.horizontal,40)
                                .padding(.vertical,8)
                                .foregroundColor(.white)
                                .background(Color.darkGreen)
                                .cornerRadius(8)
                            
                        })
                        
                        Text("")
                            .scaledFont(name: .bold, size: 32)
                        
                        Text("Show this ticket at the enterance")
                            .scaledFont(name: .regular, size: 16)
                            .foregroundColor(.gray)
                        
                        Divider()
                        
                        VStack(spacing:20) {
                            
                            HStack{
                                Text("From")
                                    .scaledFont(name: .medium, size: 16)
                                    .foregroundColor(.lightGreen)
                                Image("dottedLine")
                                Image(systemName: "bus")
                                    .foregroundColor(.lightGreen)
                                Image("dottedLineRight")
                                Text("To")
                                    .scaledFont(name: .medium, size: 16)
                                    .foregroundColor(.lightGreen)
                            }
                            
                            HStack{
                                Text(ticket.pickup ?? "")
                                    .scaledFont(name: .medium, size: 16)
                                    .foregroundColor(.lightGreen)
                                    .frame(maxWidth: .infinity)
                                
                                
                                Text(ticket.dropoff ?? "")
                                    .scaledFont(name: .medium, size: 16)
                                    .foregroundColor(.lightGreen)
                                    .frame(maxWidth: .infinity)
                            }
                            
//                            HStack{
//                                Text("start time")
//                                    .scaledFont(name: .medium, size: 16)
//                                    .frame(maxWidth: .infinity)
//
//
//                                Text("end time")
//                                    .scaledFont(name: .medium, size: 16)
//                                    .frame(maxWidth: .infinity)
//                            }
                            
                            HStack{
                                VStack(alignment: .leading, spacing: 10){
                                    
                                    HStack(alignment: .firstTextBaseline) {
                                        Image(systemName: "calendar")
                                            .foregroundColor(.lightGreen)
                                        
                                        
                                        VStack(alignment: .leading, spacing: 10){
                                            Text("Date")
                                                .scaledFont(name: .medium, size: 16)
                                                .foregroundColor(.lightGreen)
                                            
                                            
                                            Text(ticket.date?.getFormatted() ?? "")
                                                .scaledFont(name: .medium, size: 16)
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .leading, spacing: 10){
                                    
                                    HStack(alignment: .firstTextBaseline) {
                                        Image(systemName: ticket.type == "Bus" ? "bus" : "tram")
                                            .foregroundColor(.lightGreen)
                                        
                                        
                                        VStack(alignment: .leading, spacing: 10){
                                            Text("Type")
                                                .scaledFont(name: .medium, size: 16)
                                                .foregroundColor(.lightGreen)
                                            
                                            
                                            Text(ticket.type ?? "")
                                                .scaledFont(name: .medium, size: 16)
                                        }
                                    }
                                    
                                }
                            }.padding(.horizontal, 20)
                            
                            HStack{
                                VStack(alignment: .leading, spacing: 10){
                                    
                                    HStack(alignment: .firstTextBaseline) {
                                        Image(systemName: "")
                                            .foregroundColor(.lightGreen)
                                        
                                        
                                        VStack(alignment: .leading, spacing: 10){
                                            Text("Total Tickets")
                                                .scaledFont(name: .medium, size: 16)
                                                .foregroundColor(.lightGreen)
                                            
                                            
                                            Text("\(ticket.totaltickets ?? 0) Tickets")
                                                .scaledFont(name: .medium, size: 16)
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .leading, spacing: 10){
                                    
                                    HStack(alignment: .firstTextBaseline) {
                                        Image("money")
                                            .foregroundColor(.lightGreen)
                                            .offset(y: 6)
                                        
                                        VStack(alignment: .leading, spacing: 10){
                                            Text("Price")
                                                .scaledFont(name: .medium, size: 16)
                                                .foregroundColor(.lightGreen)
                                            
                                            
                                            Text("\(ticket.price?.getIn2Decimal() ?? "0") SAR")
                                                .scaledFont(name: .medium, size: 16)
                                        }
                                    }
                                    
                                }
                            }.padding(.horizontal, 20)
                            
                            
                            
                            Divider()
                            Text("#\(ticket.invoiceNo?.description ?? "0")")
                                .scaledFont(name: .semiBold, size: 36)
                            
                        }
                    }
                }
            }
        }.padding(.horizontal, 22)
            
    }
}

struct BillSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BillSheetView()
    }
}
