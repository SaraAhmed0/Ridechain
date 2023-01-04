//
//  walletActivity.swift
//  Ridechain
//
//  Created by Noura on 03/01/2023.
//

import SwiftUI

struct walletActivity: View {
    var body: some View {
        chargeWallet()
    }
}

struct chargeWallet: View {
    var body: some View {
        HStack{
            
            Button(action: {
                
            }, label: {
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
                  
                    
                    
            })
        
            Button(action: {
                
            }, label: {
                Text("ticket history")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(y: 50)
                    .padding(50)
                    .frame(width: 150, height: 150)
                    .background(Color(red:0/255 ,green:109/255 ,blue:119/255 ))
                    .cornerRadius(20)
                    .overlay(Image(systemName: "archivebox.fill").resizable().frame(width: 45,height: 45).foregroundColor(.white))
                  
                    
            })
        }
    }
}

struct walletActivity_Previews: PreviewProvider {
    static var previews: some View {
        walletActivity()
    }
}
