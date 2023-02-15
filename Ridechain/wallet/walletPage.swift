//
//  walletPage.swift
//  Ridechain
//
//  Created by Noura on 03/01/2023.
//

import SwiftUI
import Foundation
import FirebaseAuth
struct walletPage: View {
    @EnvironmentObject var dbPassenger: PassengerVM
    @State var email = "email@gmail.com"
    @EnvironmentObject var ViewModel: authViewModel

    var body: some View {
            VStack{
                
                NavigationView{
                    
                    VStack{
                        HStack{
                            
                            Text("Card")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .padding()
                                .offset(y:40)
                                .offset(x: -150)
                        }.padding(30)
                        HStack{
                            Wallet()
                        }
                        
                        HStack{
                            Text("Activity")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .offset(x: -120)
                        }
                        
                        HStack{
                            NavigationLink(destination: cardList()){
                                Text("Charge wallet")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .offset(y: 50)
                                    .padding(50)
                                    .frame(width: 150, height: 150)
                                    .background(Color(red:0/255 ,green:109/255 ,blue:119/255 ))
                                    .cornerRadius(20)
                                    .overlay(Image("payment").resizable().frame(width: 60,height: 60).foregroundColor(.white))
                            }.navigationBarTitle(Text("Wallet"))
                            
                            
                            
                            
                            
                            NavigationLink(destination: ticketHistory()){
                                Text("Ticket History")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .offset(y: 50)
                                    .padding(50)
                                    .frame(width: 150, height: 150)
                                    .background(Color(red:0/255 ,green:109/255 ,blue:119/255 ))
                                    .cornerRadius(20)
                                    .overlay(Image(systemName: "archivebox.fill").resizable().frame(width: 45,height: 45).foregroundColor(.white))
                                
                            }
                        }
                        
                        HStack{
                            Text("Account")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .offset(x: -120)
                                .offset(y:-10)
                        }
                        
//                        List{
                        NavigationLink(destination: accountInfo(passenger: Passenger(passengerNationalID: "",passengerEmail: dbPassenger.getEmail(dbPassenger.passengers), passengerName: dbPassenger.getUserName(dbPassenger.passengers)))){
                            ZStack{
                                
                                    Rectangle().frame(width: 350, height: 40).foregroundColor(.white)
                                HStack{
                                    Text("My Information").multilineTextAlignment(.leading).padding()
                                    
                                    Image(systemName: "chevron.right").padding()
                                }
                            }
                        }.padding(.bottom)
//                        }
//                        HStack{
//                            Text(String(dbPassenger.getEmail(dbPassenger.passengers)))
//                                .frame(width: 350,height: 50, alignment: .leading)
//                                .background(Color(.white))
//                                .cornerRadius(8)
//                                .offset(y: -20)
//
//                        }
                        
//                        HStack{
//                            Button(action: {
//                                ViewModel.signOut()
//                            }, label: {
//                                Text("sign Out")
//                                    .foregroundColor(Color.white)
//                                    .frame(width: 350,height: 50)
//                                    .background(Color(.red))
//                                    .cornerRadius(8)
//                                    .offset(y:-20)
//
//
//
//                            })
//                        }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(red:237/255, green: 246/255, blue: 249/255))
                        .ignoresSafeArea()
                }
                
            }
        
    }
    
}


struct Payments : Hashable {
    var paymentType: String
    var paymentImage: String
  
}

struct accountInfo : View{
    var passenger : Passenger
    @EnvironmentObject var ViewModel: authViewModel
    var body: some View {
        VStack{
            List{
                Text(passenger.passengerName ?? "")
                Text(passenger.passengerEmail ?? "")
            }
            Button(action: {
                ViewModel.signOut()
            }, label: {
                Text("sign Out")
                    .foregroundColor(Color.white)
                    .frame(width: 350,height: 50)
                    .background(Color(.red))
                    .cornerRadius(8)
                    .offset(y:-20)
                
                
                
            })
            
        }
        
    }
}


struct cardList : View{
    var cards = [Payments(paymentType: "Credit or Debit Card", paymentImage: ""),Payments(paymentType: "Apple Pay", paymentImage: "")]
    var body: some View {
        List{
            ForEach(self.cards, id: \.self) { item in
                NavigationLink(destination: charge()){
                        
                        Text(item.paymentType)
                }
            }
            
        }
        
    }
}

struct charge: View {
    @State var amount: String = ""
    @EnvironmentObject var dbPassenger: PassengerVM
    @State var showingAlert = false
    var body: some View {
        VStack{
            Text("How much do you want to charge?")
                .font(.system(size: 20).bold()).padding()
            TextField("0.0 SAR" , text: $amount)
                .frame(width: 350,height: 50, alignment: .leading)
                .background(Color(.white))
                .cornerRadius(8)
                .padding()
            
            
            KeyPad(string: $amount)
            
            Button{
                dbPassenger.updateWallet(dbPassenger.passengers, Double(amount) ?? 0.0)
                showingAlert.toggle()
            } label: {
                Text("Charge")
                    .foregroundColor(Color.white)
                    .frame(width: 350,height: 50)
                    .background(Color(red:96/255, green: 190/255, blue: 143/255))
                    .cornerRadius(8)
                    .padding()
                
                
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("Wallet Charged"), message: Text("Wallet was charged successfully"), dismissButton: .default(Text("Ok")))
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red:237/255, green: 246/255, blue: 249/255))
            .ignoresSafeArea()
        
    }
}
struct KeyPadButton: View {
    var key: String

    var body: some View {
        Button(action: { self.action(self.key) }) {
            Color.white
                .overlay(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(red:96/255, green: 190/255, blue: 143/255)))
                .overlay(Text(key))
                .foregroundColor(Color.black)
                .frame(width: 120, height: 70)


        }
    }

    enum ActionKey: EnvironmentKey {
        static var defaultValue: (String) -> Void { { _ in } }
    }

    @Environment(\.keyPadButtonAction) var action: (String) -> Void
}

extension EnvironmentValues {
    var keyPadButtonAction: (String) -> Void {
        get { self[KeyPadButton.ActionKey.self] }
        set { self[KeyPadButton.ActionKey.self] = newValue }
    }
}

#if DEBUG
struct KeyPadButton_Previews: PreviewProvider {
    static var previews: some View {
        KeyPadButton(key: "8")
            .padding()
            .frame(width: 70, height: 50)
            .previewLayout(.sizeThatFits)
            .foregroundColor(Color.black)
    }
}
#endif


struct KeyPadRow: View {
    var keys: [String]

    var body: some View {
        HStack {
            ForEach(keys, id: \.self) { key in
                KeyPadButton(key: key)
            }
        }
    }
}

struct KeyPad: View {
    @Binding var string: String

    var body: some View {
        VStack {
            KeyPadRow(keys: ["1", "2", "3"])
            KeyPadRow(keys: ["4", "5", "6"])
            KeyPadRow(keys: ["7", "8", "9"])
            KeyPadRow(keys: [".", "0", "⌫"])
        }.environment(\.keyPadButtonAction, self.keyWasPressed(_:))
    }

    private func keyWasPressed(_ key: String) {
        switch key {
        case "." where string.contains("."): break
        case "." where string == "0": string += key
        case "⌫":
            string.removeLast()
            if string.isEmpty { string = "0" }
        case _ where string == "0": string = key
        default: string += key
        }
    }
}


struct ticketHistory: View {
    @EnvironmentObject var dbTicket : TicketVM
    

   
    @State var showSheetView = false
    @State var selected:Ticket?
    var body: some View {
        
        VStack{
            Text("Tickets").font(.custom("Roboto-Medium",size:44)).padding(.trailing, 200.0)
            Divider()
            Text("Passed Tickets").font(.custom("Roboto-Medium",size:20)).padding(.trailing, 200.0)
            ScrollView {
                
                ForEach( dbTicket.tickets,id:\.id)
                {ticket in
                    if !checktime(ticket)
                        
                    {
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
                    
                    else{
                        EmptyView()
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
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color.red).frame(width: 96, height: 28)
                Text("Passed").foregroundColor(.white)
            }
            Spacer()
            Text(eticket.ticketOwner ?? "").font(.custom("Roboto-Medium",size:32)).fontWeight(.bold)

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
    
    func checktime(_ ticket :Ticket)-> Bool
    {
        let date1 = Date()
        let date2 = ticket.date ?? Date()
        if date1 <= date2  {
            return true
        }
        else
        {
            return false
        }
    }

       
    }



    

struct walletPage_Previews: PreviewProvider {
    static var previews: some View {
        walletPage()
    }
}
