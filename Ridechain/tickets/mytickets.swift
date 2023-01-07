//
//  mytickets.swift
//  Ridechain
//
//  Created by Danah  on 27/12/2022.
//

import SwiftUI

struct mytickets: View {
    let tickets: [ticket]
    var body: some View {
        
        VStack{
            Text("Tickets").font(.custom("Roboto-Medium",size:44)).padding(.trailing, 200.0)
                Divider()
            Text("Coming Tickets").font(.custom("Roboto-Medium",size:20)).padding(.trailing, 200.0)
            ScrollView {
                VStack(alignment:.leading) {
                 
                        ForEach(tickets){ticket in
                        
                            ticketinitv(nticket: ticket)
                        
                        
                        
                    }
                    
                }
                
                
            }
            
            
        }.background(colorp.slblue)
    }
}

struct choosetickets_Previews: PreviewProvider {
    static var previews: some View {
      
            
            
            mytickets(tickets:ticket.sampledata)
        
        
        
        }
    }
