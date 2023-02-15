//
//  UserType.swift
//  testt
//
//  Created by Noura on 14/02/2023.
//

import SwiftUI

struct UserType: View {
    var body: some View {
//        NavigationView{
            VStack{
                VStack{
                    Text("Welcome to Ridechain")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red:0/255, green: 109/255, blue: 119/255))
                        .padding()
                    Image("logo")
                        .resizable()
                        .frame(width: 300,height: 300,alignment: .center)
                        .padding(-100)
                }.offset(y:-150).offset(x:-50)
                
                HStack{
                    
                    NavigationLink(destination:signUpView()){
                        Text("Passenger")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .offset(y: 50)
                            .padding(50)
                            .frame(width: 164, height: 160)
                            .background(Color(red:96/255 ,green:190/255 ,blue:143/255 ))
                            .cornerRadius(20)
                            .overlay(Image(systemName: "person").resizable()
                                .frame(width: 60,height: 60)
                                .foregroundColor(.white))
                        
                    }
                    
                    NavigationLink(destination:signUpViewSP()){
                        Text("Service Provider")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .offset(y: 50)
                            .padding(50)
                            .frame(width: 164, height: 160)
                            .background(Color(red:96/255 ,green:190/255 ,blue:143/255 ))
                            .cornerRadius(20)
                            .overlay(Image(systemName: "person.line.dotted.person").resizable()
                                .frame(width: 100,height: 60)
                                .foregroundColor(.white))
                        
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red:237/255, green: 246/255, blue: 249/255))
                .ignoresSafeArea()
//        }
    }
}

struct login: View{
    var body: some View {
       // let ViewModel = AppViewModel()
                       ContentView()
                      // .environmentObject(ViewModel)
    }
}



struct UserType_Previews: PreviewProvider {
    static var previews: some View {
        UserType()
    }
}
