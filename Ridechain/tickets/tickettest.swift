//
//  tickettest.swift
//  Ridechain
//
//  Created by Danah  on 27/12/2022.
//


import Foundation
struct ticket:Identifiable
{
    var id: UUID
    var destnation:String
    var pickup:String
    var price:Double
    var date:Date
    var day:String
    var duration:String
    init(id: UUID = UUID(), destnation:String,  pickup:String ,price:Double ,date:Date,day:String,duration:String)
    
    {
        self.id=id
        self.destnation=destnation
        self.pickup=pickup
        self.price=price
        self.date=date
        self.day=day
        self.duration=duration
        
    }
}

extension ticket
{
    static let sampledata:[ticket]=[
        ticket( destnation: "Somewhere2",  pickup:"Somewhere1" ,price:25 ,date:Date(timeIntervalSinceReferenceDate: -123456789.0),day:"sunday",duration:"15min"),
        ticket( destnation: "Somewhere3",  pickup:"Somewhere4" ,price:25 ,date:Date(timeIntervalSinceReferenceDate: -123456789.0),day:"sunday",duration:"15min"),
        ticket( destnation: "Somewhere5",  pickup:"Somewhere6" ,price:25 ,date:Date(timeIntervalSinceReferenceDate: -123456789.0),day:"sunday",duration:"15min")
    ]
    
}


