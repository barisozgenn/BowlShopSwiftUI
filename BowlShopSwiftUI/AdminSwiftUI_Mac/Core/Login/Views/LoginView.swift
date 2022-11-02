//
//  LoginView.swift
//  AdminSwiftUI_Mac
//
//  Created by Baris OZGEN on 30.10.2022.
//
import SwiftUI

struct LoginView: View {
    @StateObject private var vm = LoginViewModel()

    private let gridItem = GridItem(.flexible(), spacing: 14)
    var body: some View {
        ZStack(alignment: .top){
            VStack{
                LinearGradient(colors: [.green, .cyan], startPoint: .bottom, endPoint: .top)
                    .opacity(0.7)
                    .ignoresSafeArea()
                    .frame(minWidth: 1024)
                    .frame(height: 429)
                    .padding(.bottom, -10)
                
                Color(.lightGray)
                    .opacity(0.4)
            }
            VStack{
                headerView
                ZStack{
                    phoneNumberView
                    otpView
                }
                
                keyboardView
            }
            .clipped()
            .background(.white)
            .frame(width: 430, height: 500)
        }
        
    }
}

extension LoginView {
    private var headerView: some View {
        ZStack(alignment: .top){
            LinearGradient(colors: [.green, .cyan], startPoint: .bottom, endPoint: .top)
                .opacity(0.7)
                .ignoresSafeArea()
            VStack{
                Text((vm.loginStep == .phone ? "Continue with your phone" : "Verify your phone to login").capitalized)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                Spacer()
                Image(vm.loginStep == .phone ? "img-verify-phone" : "img-verify-otp")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 128)
                Spacer()
                HStack(spacing:0){
                    Text(vm.loginStep == .phone ? "You can login or register with the SMS verification code." : "+\(vm.phoneCountryCodeText) \(vm.phoneNumberText)")
                        .lineLimit(2)
                        .font(vm.loginStep == .phone ?  .title3 : .title2)
                        .fontWeight(.semibold)
                        .padding()
                    if vm.loginStep == .otp {
                        
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                            .onTapGesture {
                                withAnimation(.spring()){
                                    vm.loginStep = .phone
                                }
                            }
                    }
                }
               
            }
            .padding(.vertical)
            .padding(.bottom, 114)
        }
        .foregroundColor(.white)
        .padding(.bottom, -107)
    }
    private var phoneNumberView: some View {
        ZStack{
            GeometryReader { geo in
                
                Wave(waveHeight: 14, phase: Angle(degrees: Double(geo.frame(in: .global).minY) * 0.7))
                    .foregroundColor(.white)
            }
            HStack(alignment: .bottom){
                VStack(alignment: .leading){
                    Text(vm.warningPhoneNumberText.isEmpty ? "Type your phone" : vm.warningPhoneNumberText)
                        .font(.subheadline)
                        .padding(.vertical,4)
                        .foregroundColor(vm.warningPhoneNumberText.isEmpty ? .gray : .orange)
                    HStack{
                        HStack{
                            Text(vm.selectedCountry.emoji)
                            Text("+\(vm.selectedCountry.phone)")
                        }
                        Text(vm.phoneNumberText)
                            .lineLimit(1)
                            .frame(maxWidth: 150, alignment: .leading)
                    }
                    Divider()
                        .background(.primary)
                        .padding(.top, 0)
                        .padding(.trailing, 7)
                    
                }
                .foregroundColor(Color(.darkGray))
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring()){
                        vm.sendSMSButton()
                    }
                }) {
                    Text("Continue")
                        .font(.headline)
                }
                .keyboardShortcut(.return, modifiers: [])
                .disabled(vm.loginStep == .phone ? false : true)
                .buttonStyle(.borderless)
                .frame(width: 80)
                .foregroundColor(Color(.white))
                .padding()
                .background(.green)
                .cornerRadius(4)
                
            }
            .font(.title3)
            .fontWeight(.semibold)
            .padding()
            .padding(.top, 14)
        }
        .frame(height: 100)
        .offset(x: vm.loginStep == .phone ? 0 : -430)
    }
    private var otpView: some View {
        ZStack{
            GeometryReader { geo in
                Wave(waveHeight: 14, phase: Angle(degrees: Double(geo.frame(in: .global).minY) * 0.3))
                    .foregroundColor(.white)
            }
            HStack(alignment: .bottom){
                VStack(alignment: .leading){
                    Text(vm.warningOtpText.isEmpty ? "Type sms confirmation code" : vm.warningOtpText)
                        .font(.subheadline)
                        .padding(.vertical,4)
                        .foregroundColor(vm.warningOtpText.isEmpty ? .gray : .orange)
                    HStack{
                        Image(systemName: "lock.shield")
                        Text(vm.otpText)
                            .lineLimit(1)
                            .frame(maxWidth: 150, alignment: .leading)
                    }
                    Divider()
                        .background(.primary)
                        .padding(.top, 0)
                        .padding(.trailing, 7)
                    
                }
                .foregroundColor(Color(.darkGray))
                
                Spacer()
                
                Button(action: {
                    vm.sendOTPButton()
                }) {
                    Text("Verify")
                        .font(.headline)
                }
                .keyboardShortcut(.return, modifiers: [])
                .disabled(vm.loginStep == .otp ? false : true)
                .buttonStyle(.borderless)
                .frame(width: 80)
                .foregroundColor(Color(.white))
                .padding()
                .background(.green)
                .cornerRadius(4)
                
            }
            .font(.title3)
            .fontWeight(.semibold)
            .padding()
            .padding(.top, 14)
        }
        .frame(height: 100)
        .offset(x: vm.loginStep == .otp ? 0 : 430)
    }
    
    private var keyboardView: some View {
        LazyVGrid(columns:
                    Array(repeating: gridItem, count: 11), spacing: 14) {
            ForEach(vm.padNumbers, id: \.self) { keyTag in
                
                Button(action: {
                    withAnimation(.spring()){
                        switch vm.loginStep {
                        case .phone:
                            vm.setPhoneNumberText(keyTag: keyTag)
                        case .otp:
                            vm.setOTPText(keyTag: keyTag)
                        }
                    }
                }) {
                    if keyTag != vm.padNumbers.last {
                        Text(keyTag)
                            .font(.title2)
                            .frame(width: 30,height: 45)
                    }
                    else {
                        Image(systemName: keyTag)
                            .frame(width: 35,height: 45)
                    }
                }
                .buttonStyle(.borderless)
            .keyboardShortcut(getKeyboardShortcut(keyTag: keyTag))
                .fontWeight(.bold)
                .background(.white.opacity(keyTag.isEmpty ? 0.29 : 1))
                .cornerRadius(7)
            }
        }
                    .foregroundColor(Color(.darkGray))
                    .padding(14)
                    .background(Color(.lightGray).opacity(0.5))
    }
    
    func getKeyboardShortcut(keyTag: String) -> KeyboardShortcut {
        if keyTag == vm.padNumbers.last {
            return KeyboardShortcut(.delete, modifiers: [])
        } else {
            return KeyboardShortcut(KeyEquivalent( Character(keyTag)), modifiers: [])
        }
    }
    struct Wave: Shape {
        
        var waveHeight: CGFloat
        var phase: Angle
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: 0, y: rect.maxY)) // Bottom Left
            
            for x in stride(from: 0, through: rect.width, by: 1) {
                let relativeX: CGFloat = x / 50 //wavelength
                let sine = CGFloat(sin(relativeX + CGFloat(phase.radians)))
                let y = waveHeight * sine //+ rect.midY
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY)) // Top Right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // Bottom Right
            
            return path
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
