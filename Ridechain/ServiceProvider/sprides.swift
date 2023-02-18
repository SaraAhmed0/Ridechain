//
//  sprides.swift
//  ServiceProvider
//
//  Created by Danah  on 30/01/2023.
//

import SwiftUI

struct sprides: View {
    @EnvironmentObject var dbRide: RideVM
    @EnvironmentObject var dbPassenger: PassengerVM
    @State var showSheetView = false
    @State var showEditSheetView = false
    @State private var showDeleteAlert = false
    @State var selected:Ride?
    private let calendar: Calendar
    private let monthDayFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    static var now = Date()
    @State private var selectedDate = Self.now
    
    init(){
        self.calendar = Calendar(identifier: .gregorian)
        self.monthDayFormatter = DateFormatter(dateFormat: "MMMM yyyy", calendar: calendar)
        self.dayFormatter = DateFormatter(dateFormat: "d", calendar: calendar)
        self.weekDayFormatter = DateFormatter(dateFormat: "EEEEE", calendar: calendar)
    }
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle().foregroundColor(colorp.slblue).ignoresSafeArea()
                VStack{
                    HStack{
                        let name = "Welcome " + dbPassenger.getUserName(dbPassenger.passengers)
                        Text(name).font(.custom("Roboto-Medium",size:30))
                        Spacer()
//                            .padding()
                        NavigationLink(destination: spProfile(passenger: Passenger(passengerNationalID: "",passengerEmail: dbPassenger.getEmail(dbPassenger.passengers), passengerName: dbPassenger.getUserName(dbPassenger.passengers)))){
                            Image(systemName: "person.circle").font(.largeTitle)
                        }
                    }
                    //                Spacer()
                    CalendarWeekListView(
                        calendar: calendar,
                        date: $selectedDate,
                        selectedDate: $selectedDate,
                        content: { date in
                            Button(action: {selectedDate = date}){
                                ZStack{
                                    //80
                                    Rectangle().frame( height: 80).cornerRadius(8).foregroundColor(Color("box")).shadow(radius: 0.6).opacity((calendar.isDate(date, inSameDayAs: selectedDate) ? 1 : 0))
                                    VStack{
                                        Text("000")
                                            .font(.system(size: 12))
                                            .foregroundColor(.clear)
                                            .overlay(Text(weekDayFormatter.string(from: date))
                                                .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? Color("darkGreen") : calendar.isDateInToday(date) ? Color("darkGreen") : .gray))
                                        
                                        Text("00")
                                            .font(.system(size:16))
                                            .padding(3)
                                            .foregroundColor(.clear)
                                            .overlay(Text(dayFormatter.string(from: date)).fontWeight(.bold)
                                                .font(.system(size:18))
                                                .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? Color("darkGreen") : calendar.isDateInToday(date) ? Color("darkGreen") : date < Date() ? .gray:Color("darkGreen")))
                                        Spacer().frame(height:3)
                                    }
                                }
                            }
                        }
                        ,title: { date in
                            HStack{
                                Text(monthDayFormatter.string(from: selectedDate))
                                    .font(.headline)
                                    .padding()
                            }
                            .padding(.bottom, 6)
                        } ,weekSwitcher1: { date in
                            Button{
                                guard let newDate = calendar.date(byAdding: .weekOfMonth , value: -1, to: selectedDate)
                                else{
                                    return
                                }
                                selectedDate = newDate
                            }label: {
                                Label(
                                    title: { Text("Previous")},
                                    icon: {Image(systemName: NSLocale.current.languageCode == "ar" ? "chevron.right" : "chevron.left" ).foregroundColor(Color("darkGreen"))}
                                )
                                .labelStyle(IconOnlyLabelStyle())
                                .padding(.horizontal)
                            }
                        }, weekSwitcher2: { date in
                            Button{
                                guard let newDate = calendar.date(byAdding: .weekOfMonth , value: 1, to: selectedDate)
                                else{
                                    return
                                }
                                selectedDate = newDate
                            }label: {
                                Label(
                                    title: { Text("Next")},
                                    icon: {Image(systemName: NSLocale.current.languageCode == "ar" ? "chevron.left" : "chevron.right").foregroundColor(Color("darkGreen"))}
                                )
                                .labelStyle(IconOnlyLabelStyle())
                                .padding(.horizontal)
                            }
                        }
                    )
                    Divider()
                    ForEach(dbRide.rides.indices, id: \.self){ index in
                        if calendar.isDate(selectedDate, inSameDayAs:  dbRide.rides[index].rideDate ?? Date()){
                            sprideinitv(ride : dbRide.rides[index])
                        }
                    }
                    Spacer()
                    
                }.padding().background(colorp.slblue)
                
            }
        }
    }
    
}

struct CalendarWeekListView<Day: View, Title: View, WeekSwitcher1: View, WeekSwitcher2: View>: View{
    
    private var calendar: Calendar
    @Binding private var date: Date
    private let content: (Date) -> Day
    private let title: (Date) -> Title
    private let weekSwitcher1: (Date) -> WeekSwitcher1
    private let weekSwitcher2: (Date) -> WeekSwitcher2
    private let daysInWeek = 7
    
    init(
        calendar: Calendar,
        date:Binding<Date>,
        selectedDate:Binding<Date>,
        @ViewBuilder content: @escaping (Date) -> Day,
        
        @ViewBuilder title: @escaping (Date) -> Title,
        @ViewBuilder weekSwitcher1: @escaping (Date) -> WeekSwitcher1,
        @ViewBuilder weekSwitcher2: @escaping (Date) -> WeekSwitcher2){
            self.calendar = calendar
            self._date = date
            
            self.content = content
            
            self.title = title
            self.weekSwitcher1 = weekSwitcher1
            self.weekSwitcher2 = weekSwitcher2
            
        }
    var body: some View{
//        let month = date.startOfMonth(using: calendar)
//        let days = makeDays()
//
//
//        VStack(spacing:1){
//
//
//            HStack{
//
//                self.weekSwitcher1(month)
//                self.title(month)
//                self.weekSwitcher2(month)
//            }
//
//            HStack{
//                ForEach(days, id: \.self) { date in
//
//
//                    content(date)
//
//
//
//
//                }
//            }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
//                .onEnded({ value in
//                    if value.translation.width < 0 {
//                        guard let newDate = calendar.date(byAdding: .weekOfMonth , value: NSLocale.current.languageCode == "ar" ? -1 : 1, to: date)
//                        else{
//                            return
//                        }
//                        date = newDate
//                    }
        let month = date.startOfMonth(using: calendar)
             let days = makeDays()
             VStack(spacing:1){
              HStack{
               self.weekSwitcher1(month)
               self.title(month)
               self.weekSwitcher2(month)
             }
              HStack{
               ForEach(days, id: \.self) { date in
                content(date)
              }
             }
            }.gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
               .onEnded { value in
                       print(value.translation)
                       switch(value.translation.width, value.translation.height) {
                        case (...0, -30...30):
                        guard let newDate = calendar.date(byAdding: .weekOfMonth , value: NSLocale.current.languageCode == "ar" ? -1 : 1, to: date)
                        else{
                         return
                       }
                        date = newDate
                        case (0..., -30...30):
                        guard let newDate = calendar.date(byAdding: .weekOfMonth , value:NSLocale.current.languageCode == "ar" ? 1 : -1, to: date)
                        else{
                         return
                       }
                        date = newDate
                        default: print("no clue") }
                     
               
                    if value.translation.width > 0 {
                        guard let newDate = calendar.date(byAdding: .weekOfMonth , value: NSLocale.current.languageCode == "ar" ? 1 : -1, to: date)
                        else{
                            return
                        }
                        date = newDate
                    }
                }).animation(.easeIn(duration: 0.1))
        }
        
    
    
}

private extension CalendarWeekListView{
    func makeDays() -> [Date]{
        guard let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: date),
              let lastWeek = calendar.dateInterval(of: .weekOfMonth, for: firstWeek.end - 1)
        else{
            return []
        }
        let dateInterval = DateInterval(start: firstWeek.start, end: lastWeek.end)
        
        return calendar.generateDays(for: dateInterval)
    }
}

private extension Calendar{
    func generateDates(for dateInterval: DateInterval, matching components: DateComponents) -> [Date]{
        var dates = [dateInterval.start]
        
        enumerateDates(startingAfter: dateInterval.start, matching: components, matchingPolicy: .nextTime) { date,_, stop in
            
            guard let date = date else {return}
            guard date < dateInterval.end else{
                stop = true
                return
            }
            dates.append(date)
        }
        return dates
    }
    
    
    func generateDays( for dateInterval: DateInterval) -> [Date]{
        generateDates(
            for: dateInterval,matching: dateComponents([.hour,.minute, .second], from: dateInterval.start))
        
    }
}

private extension Date{
    func startOfMonth(using calendar: Calendar) -> Date {
        calendar.date(
            from: calendar.dateComponents([.year, .month], from: self)) ?? self
        
    }
}

private extension DateFormatter {
    convenience init ( dateFormat: String, calendar: Calendar){
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
        self.locale = Locale(identifier: NSLocale.current.languageCode ?? "en")
    }
}


struct spProfile : View{
    var passenger : Passenger
    @EnvironmentObject var ViewModel: authViewModel
    var body: some View{
        ZStack{
            Rectangle().foregroundColor(colorp.slblue).ignoresSafeArea()
            VStack{
                List{
                    Text(passenger.passengerName ?? "")
                    Text(passenger.passengerEmail ?? "")
                    NavigationLink(destination: spTicket() ){
                        Text("Booked Tickets")
                    }
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
}

struct spTicket : View {
    var body: some View {
        EmptyView()
    }
}
