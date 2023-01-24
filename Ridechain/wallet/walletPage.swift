//
//  walletPage.swift
//  Ridechain
//
//  Created by Noura on 03/01/2023.
//

import SwiftUI

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
                            NavigationLink(destination: charge()){
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
                            
                            
                            
                            
                            
                            NavigationLink(destination: Text("hel")){
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
                        
                        HStack{
                            Text(String(email))
                                .frame(width: 350,height: 50, alignment: .leading)
                                .background(Color(.white))
                                .cornerRadius(8)
                                .offset(y: -20)
                            
                        }
                        
                        HStack{
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
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(red:237/255, green: 246/255, blue: 249/255))
                        .ignoresSafeArea()
                }
                
            }
        
    }
    
}


struct charge: View {
    @State var amount: String = ""
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
            
            Button(action: {
               
            }, label: {
                Text("Charge")
                    .foregroundColor(Color.white)
                    .frame(width: 350,height: 50)
                    .background(Color(red:96/255, green: 190/255, blue: 143/255))
                    .cornerRadius(8)
                    .padding()
                
                
            })
            
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
struct walletPage_Previews: PreviewProvider {
    static var previews: some View {
        walletPage()
    }
}
