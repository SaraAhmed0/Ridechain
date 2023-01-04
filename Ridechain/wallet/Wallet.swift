//
//  Wallet.swift
//  Ridechain
//
//  Created by Noura on 03/01/2023.
//

import SwiftUI

struct Wallet: View {
    var body: some View {
        VStack{
            VStack{
                VStack{
                    Image("card")
                        .resizable()
                        .scaledToFit()
                        .overlay(walletbalance(), alignment: .topLeading)
                        
                }
                
            }
        }
    }
}

struct walletbalance: View {
    @State var balance = 0
    @State var points = 0
    var body: some View{
        VStack{
            Spacer()
            Text("Balance")
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .offset(y:-50)
                .offset(x:15)
                .padding(0.1)
            HStack{
                Text(String(balance)+" SAR ")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(y:-50)
                    .offset(x:25)
                
            }.padding(.bottom)
            Spacer()
        }
        Spacer()
        VStack{
            Spacer()
            Text("Loyalty Points")
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .offset(y:50)
                .offset(x:36)
                .padding(0.1)
            HStack{
                Text(String(points)+" Points")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(y:45)
                    .offset(x:30)
                
            }.padding(.bottom)
            Spacer()
        }
    }
    
    struct Wallet_Previews: PreviewProvider {
        static var previews: some View {
            Wallet()
        }
    }
}
