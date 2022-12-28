//
//  SignViews.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 26/05/1444 AH.
//

import SwiftUI

struct SignViews: View {
    @EnvironmentObject var viewModel: authViewModel

    var body: some View {
       
        NavigationView{
            if viewModel.signedIn{

                VStack{
                    ContentView()
                    
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("sign Out")
                            .foregroundColor(Color.white)
                            .frame(width: 350,height: 50)
                            .background(Color(red:96/255 ,green:190/255 ,blue:143/255 ))
                            .cornerRadius(8)
                            .padding( )
                        
                    })
                }
            }
            else{
                signInView()
            }
            
           
            
            
                
        }.onAppear{
            viewModel.signedIn = viewModel.isSignedIn
           }
        
    }
}

struct signInView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: authViewModel

    var body: some View {
        
        VStack{
            Spacer()
           
            
            VStack{
                
                Text("Email")
                    .font(.system(size: 20).bold())
                    .foregroundColor(Color(red:0/255 ,green:168/255 ,blue:184/255 ))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.all)
                
                TextField("example@domain.com", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none )
                    .padding()
                    .background(Color(.white))
                
                
                
                Text("Password")
                    .font(.system(size: 20).bold())
                    .foregroundColor(Color(red:0/255 ,green:168/255 ,blue:184/255 ))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.all)
                
                
                SecureField ("********", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none )
                    .padding()
                    .background(Color(.white))
                
                
                
                Spacer()
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signIn(email: email, password: password)
                    
                }, label: {
                    Text("Sign In")
                        .foregroundColor(Color.white)
                        .frame(width: 350,height: 50)
                        .background(Color(red:96/255 ,green:190/255 ,blue:143/255 ))
                        .cornerRadius(8)
                })
                NavigationLink("create account", destination: signUpView())
                    .padding()
            }.padding()
            Spacer()
            Spacer()
            
        }.navigationTitle("Welcome Back!")
            .background(Color(red:237/255, green: 246/255, blue: 249/255))
        
        
        
    }
    
}

struct signUpView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: authViewModel

    var body: some View {
        
        VStack{
            Spacer()
            
            
            VStack{
                
                Text("Email")
                    .font(.system(size: 20).bold())
                    .foregroundColor(Color(red:0/255 ,green:168/255 ,blue:184/255 ))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.all)
                
                TextField("example@domail.com", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none )
                    .padding()
                    .background(Color(.white))
                
                
                
                Text("Password")
                    .font(.system(size: 20).bold())
                    .foregroundColor(Color(red:0/255 ,green:168/255 ,blue:184/255 ))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.all)
                
                
                SecureField ("********", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none )
                    .padding()
                    .background(Color(.white))
                
                
                
                Spacer()
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signUp(email: email, password: password)
                    
                }, label: {
                    Text("sign Up")
                        .foregroundColor(Color.white)
                        .frame(width: 350,height: 50)
                        .background(Color(red:96/255 ,green:190/255 ,blue:143/255 ))
                        .cornerRadius(8)
                })
                
            }.padding()
            Spacer()
            Spacer()
            
        }.navigationTitle("Join Us Now")
            .background(Color(red:237/255, green: 246/255, blue: 249/255))
        
        
        
    }
    
}


struct SignViews_Previews: PreviewProvider {
    static var previews: some View {
        SignViews()
    }
}
