//
//  SignUpFormVM.swift
//  Ridechain
//
//  Created by Sara AlMezeini on 24/07/1444 AH.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Combine



let db = Firestore.firestore()

class SignUpFormVM: ObservableObject{
    
    @Published var Fullname = ""
    @Published var nationalID = ""
    @Published var city = ""
    @Published var email = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    @Published var isValid = false
    @Published var PasswordinlineError = ""
    @Published var cityinlineError = ""
    @Published var nationalIDinlineError = ""
    @Published var EmailinlineError = ""
    @Published var FullNameinlineError = ""
    @Published var cancellables =  Set<AnyCancellable>()
    
    // Minimum 6 characters at least 1 Alphabet and 1 Number
    let passwordCheck = NSPredicate(format: "SELF MATCHES %@",  "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$")
    
    let emailCheck = NSPredicate(format: "SELF MATCHES %@",  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    
    // full Name is not empty
    private var IsFullNameEmptyPublisher: AnyPublisher<Bool, Never>{
        $Fullname.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.isEmpty
            }.eraseToAnyPublisher()
    }
    
    // name is long enough
    private var IsFullNameValidLengthPublisher: AnyPublisher<Bool, Never>{
        $Fullname.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.count > 0
            }.eraseToAnyPublisher()
    }
    
    // vaild format email
    private var IsEmailVaildFormatPublisher: AnyPublisher<Bool, Never>{
        $email.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                self.emailCheck.evaluate(with: $0)
            }.eraseToAnyPublisher()
    }
    // email is not empty
    private var IsEmailEmptyPublisher: AnyPublisher<Bool, Never>{
        $email.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.isEmpty
            }.eraseToAnyPublisher()
    }
    
  
    
    // nationalID is long enough
    private var IsNationalIDValidLengthPublisher: AnyPublisher<Bool, Never>{
        $nationalID.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.count > 10
            }.eraseToAnyPublisher()
    }
    
    // NationalID is not empty
    private var IsNationalIDEmptyPublisher: AnyPublisher<Bool, Never>{
        $nationalID.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.isEmpty
            }.eraseToAnyPublisher()
    }
    
    // city is not empty
    private var IsCityEmptyPublisher: AnyPublisher<Bool, Never>{
        $city.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.isEmpty
            }.eraseToAnyPublisher()
    }
    private var IsCityValidLengthPublisher: AnyPublisher<Bool, Never>{
        $city.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.count > 2
            }.eraseToAnyPublisher()
    }
    
    private var IsCityVaildFormatPublisher: AnyPublisher<Bool, Never>{
        $city.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                self.emailCheck.evaluate(with: $0)
            }.eraseToAnyPublisher()
    }
    //password is not empty
    private var IsPasswordEmptyPublisher: AnyPublisher<Bool, Never>{
        $password.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.isEmpty
            }.eraseToAnyPublisher()
    }
    
    // passwords match
    private var IsPasswordMatchPublisher: AnyPublisher<Bool, Never>{
        Publishers.CombineLatest($password , $passwordAgain)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map{ $0 == $1 }
            .eraseToAnyPublisher()
    }
    
    // strong password:
    // 1. more than 6 chars
    // 2. has letters and numbers
    private var IsPasswordStrongPublisher: AnyPublisher<Bool, Never>{
        $password.debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{ self.passwordCheck.evaluate(with: $0) }
            .eraseToAnyPublisher()
    }
    
    private var IsPasswordVaildPublisher: AnyPublisher<PasswordStatus, Never>{
        Publishers.CombineLatest3(IsPasswordEmptyPublisher, IsPasswordStrongPublisher ,IsPasswordMatchPublisher)
            .map{
                if $0  { return PasswordStatus.empty }
                if !$1 { return PasswordStatus.weakPassword }
                if !$2 { return PasswordStatus.doesntMatch }
                return PasswordStatus.valid
            }.eraseToAnyPublisher()
    }
    
    
    private var IsEmailVaildPublisher: AnyPublisher<EmailStatus, Never>{
        Publishers.CombineLatest(IsEmailVaildFormatPublisher, IsEmailEmptyPublisher)
            .map{
                if !$0 { return EmailStatus.wrongFormat }
                if $1  { return EmailStatus.empty }
                return EmailStatus.valid
            }.eraseToAnyPublisher()
    }
    
    private var IsNationalIDVaildPublisher: AnyPublisher<NationalIDStatus, Never>{
        Publishers.CombineLatest(IsNationalIDValidLengthPublisher, IsNationalIDEmptyPublisher)
            .map{
                if !$0 { return NationalIDStatus.wrongFormat }
                if $1  { return NationalIDStatus.empty }
                return NationalIDStatus.valid
            }.eraseToAnyPublisher()
    }
    
    private var IsFullNameVaildPublisher: AnyPublisher<FullNameStatus, Never>{
        Publishers.CombineLatest(IsFullNameEmptyPublisher , IsFullNameValidLengthPublisher)
            .map{
                if $0  { return FullNameStatus.empty }
                if !$1 { return FullNameStatus.tooShort }
                return FullNameStatus.valid
            }.eraseToAnyPublisher()
    }
    
    private var IsCityVaildPublisher: AnyPublisher<CityStatus, Never>{
        Publishers.CombineLatest(IsCityEmptyPublisher , IsCityVaildFormatPublisher)
            .map{
                if $0  { return CityStatus.empty }
                if !$1 { return CityStatus.tooShort }
                return CityStatus.valid
            }.eraseToAnyPublisher()
    }
    
    init(){
        IsPasswordVaildPublisher
            .dropFirst()
            .receive(on: RunLoop.main )
            .map{
                PasswordStatus in
                switch PasswordStatus{
                case .empty:
                    return "Password cannot be empty"
                case .weakPassword:
                    return "Password Must be:\n1) At least 6 Charcters\n2) containt 1 Alphabet and 1 Number"
                case .doesntMatch:
                    return "Password does not match"
                case .valid:
                    return ""
                }
            }.assign(to: \.PasswordinlineError , on: self )
            .store(in: &cancellables)
        
        IsEmailVaildPublisher
            .dropFirst()
            .receive(on: RunLoop.main )
            .map{
                EmailStatus in
                switch EmailStatus{
                case .empty:
                    return "Email cannot be empty"
                case .wrongFormat:
                    return "Invalid email format"
                case .valid:
                    return ""
                }
            }.assign(to: \.EmailinlineError , on: self )
            .store(in: &cancellables)
        
        
        IsNationalIDVaildPublisher
            .dropFirst()
            .receive(on: RunLoop.main )
            .map{
                NationalIDStatus in
                switch NationalIDStatus{
                case .empty:
                    return "National ID cannot be empty"
                case .wrongFormat:
                    return "Invalid national ID format"
                case .valid:
                    return ""
                }
            }.assign(to: \.nationalIDinlineError , on: self )
            .store(in: &cancellables)
        
        
        IsFullNameVaildPublisher
            .dropFirst()
            .receive(on: RunLoop.main )
            .map{
                FullNameStatus in
                switch FullNameStatus{
                case .empty:
                    return "Name cannot be empty"
                case .tooShort:
                    return "Name is too short"
                case .valid:
                    return ""
                }
            }.assign(to: \.FullNameinlineError , on: self )
            .store(in: &cancellables)
        
        IsCityVaildPublisher
            .dropFirst()
            .receive(on: RunLoop.main )
            .map{
                CityStatus in
                switch CityStatus{
                case .empty:
                    return "City cannot be empty"
                case .tooShort:
                    return "City is too short"
                case .valid:
                    return ""
                }
            }.assign(to: \.cityinlineError , on: self )
            .store(in: &cancellables)
    }
    
    
    //model
    enum PasswordStatus{
        case empty
        case weakPassword
        case doesntMatch
        case valid
    }
    
    enum CityStatus{
        case empty
        case tooShort
        case valid
    }
    
    enum EmailStatus{
        case empty
        case wrongFormat
        case valid
    }
    
    enum NationalIDStatus{
        case empty
        case wrongFormat
        case valid
    }
    
    
    enum FullNameStatus{
        case empty
        case tooShort
        case valid
    }
}
