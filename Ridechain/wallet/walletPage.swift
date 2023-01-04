//
//  walletPage.swift
//  Ridechain
//
//  Created by Noura on 03/01/2023.
//

import SwiftUI

struct walletPage: View {
    @State var email = "email@gmail.com"
    @EnvironmentObject var ViewModel: authViewModel

    var body: some View {
        VStack{
            HStack{
                Text("Wallet")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                Spacer()
                
                
                Text("Card")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .offset(y:50)
                    .offset(x: -310)
                
            }.padding()
            
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
                walletActivity()
            }
            
            HStack{
                Text("Account")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .offset(x: -120)
            }
            
            HStack{
                Text(String(email))
                    .frame(width: 350,height: 50, alignment: .leading)
                    .background(Color(.white))
                    .cornerRadius(8)
              
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
                        .padding()
                        
                    
                })
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red:237/255, green: 246/255, blue: 249/255))
            .ignoresSafeArea()
    }
}
struct walletPage_Previews: PreviewProvider {
    static var previews: some View {
        walletPage()
    }
}
