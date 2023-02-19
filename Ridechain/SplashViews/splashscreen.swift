//
//  splashscreen.swift
//  testt
//
//  Created by Noura on 14/02/2023.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct splashscreen: View {
    
    @EnvironmentObject var dbPassenger: PassengerVM
    @EnvironmentObject var viewModel : authViewModel
   
//    var user : Passenger
  
    @State  var isActiveSignin : Bool = false
    @State  var isActiveSignup : Bool = false
   
    var body: some View {
        if isActiveSignin && viewModel.isSignedIn {
            let id = Auth.auth().currentUser?.uid
            let user = user(id : id ?? "", users: dbPassenger.passengers)
            if user == "P"{
                TabBar()
            }else if user == "S"{
                tabbarSP()
            } else if user == ""{
                logoSplash(isActiveSignin: $isActiveSignin)
            }
            
        }else if viewModel.isSignedIn{
           logoSplash(isActiveSignin: $isActiveSignin)
            
        }else if isActiveSignup{
            sign()
        }else if viewModel.isSignedIn == false{
            logoSplashSignout(isActiveSignup: $isActiveSignup)
        }
        
    }
    func user(id: String, users: [Passenger]) -> String{
//      var user : Passenger = Passenger()
        var userType = ""
        for i in users{
          if i.id == id {
//            user = i
            print("id: "+id)
            userType = i.userType ?? ""
          }else{
              print("user not found")
          }
        }
        print("usertype is: "+userType)
        return userType
      }
}



struct logoSplash : View{
    @Binding  var isActiveSignin : Bool
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View{
        
            VStack{
                VStack{
                    VStack{
                        Image("logo")
                            .resizable()
                            .frame(width: 500,height: 500,alignment: .center)
                            .aspectRatio(contentMode: .fill)
                        
                    }.scaleEffect(size)
                        .opacity(opacity)
                        .onAppear{
                            withAnimation(.easeIn(duration: 1.2)){
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                        }
                    
                    
                }.onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        self.isActiveSignin=true
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red:237/255, green: 246/255, blue: 249/255))
            .ignoresSafeArea()
        
    }
}

struct logoSplashSignout : View{
    @Binding  var isActiveSignup : Bool
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View{
        
            VStack{
                VStack{
                    VStack{
                        Image("logo")
                            .resizable()
                            .frame(width: 500,height: 500,alignment: .center)
                            .aspectRatio(contentMode: .fill)
                        
                    }.scaleEffect(size)
                        .opacity(opacity)
                        .onAppear{
                            withAnimation(.easeIn(duration: 1.2)){
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                        }
                    
                    
                }.onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        self.isActiveSignup = true
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red:237/255, green: 246/255, blue: 249/255))
            .ignoresSafeArea()
        
    }
}
//struct splashscreen_Previews: PreviewProvider {
//    static var previews: some View {
//        splashscreen()
//    }
//}
