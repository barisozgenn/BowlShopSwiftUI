//
//  LoginViewModel.swift
//  AdminSwiftUI_Mac
//
//  Created by Baris OZGEN on 30.10.2022.
//


import Combine
class LoginViewModel: ObservableObject {
    @Published var loginStep : ELoginStep = .phone
    @Published var padNumbers = ["1","2","3","4","5","6","7","8","9","0","delete.left"]
    @Published var phoneCountryCodeText: String = "49"
    @Published var phoneNumberText: String = ""
    @Published var otpText: String = ""
    
    @Published var warningPhoneNumberText: String = ""
    @Published var warningOtpText: String = ""
    
    @Published var selectedCountry = CountriesQuery.Data.Country(code: "DE", name: "Germany", emoji: "🇩🇪", phone: "49")

    //MARK: Phone Number Section
    func setPhoneNumberText(keyTag: String){
        
        //check if empty button pressed
        guard !keyTag.isEmpty else {return}
        
        // number button pressed
        if let numberButton = Int(keyTag),
           phoneNumberText.count < 16 {
            phoneNumberText += "\(numberButton)"
            return
        }
        
        // delete button pressed
        if keyTag == padNumbers.last,
           !phoneNumberText.isEmpty {
            phoneNumberText.removeLast()
        }
    }
    
    func sendSMSButton(){
        if phoneNumberText.count < 10 ||
           phoneNumberText.count > 15 {
            warningPhoneNumberText = "⚠ Invalid phone number"
            return
        }
        warningPhoneNumberText = ""
        loginStep = .otp
    }
    
    // MARK: OTP Section
    func setOTPText(keyTag: String){
        
        //check if empty button pressed
        guard !keyTag.isEmpty else {return}
        
        // number button pressed
        if let numberButton = Int(keyTag),
           otpText.count < 7 {
            otpText += "\(numberButton)"
            return
        }
        
        // delete button pressed
        if keyTag == padNumbers.last,
           !otpText.isEmpty {
            otpText.removeLast()
        }
    }
    
    func sendOTPButton(){
        if phoneNumberText.count != 6 {
            warningOtpText = "⚠ Invalid confirmation code"
            return
        }
        warningOtpText = ""
    }
    
    enum ELoginStep : Int {
        case phone
        case otp
    }
}

