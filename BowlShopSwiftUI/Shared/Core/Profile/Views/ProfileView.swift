//
//  ProfileView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 4.11.2022.
//

import SwiftUI
struct ProfileView: View {
    @StateObject var vm = ProfileViewModel()
         
    @State var imagePickerPresented = false
    @State private var presentLogoutAlert = false
    
    @Binding var isUserProfileSaved: Bool
    
    private let gridItem = GridItem(.flexible(), spacing: 14)
    var gradientBackgroundVisibility = true

    var body: some View {
        ZStack(alignment: .top){
            
            if gradientBackgroundVisibility {
                LinearGradient(colors: [.green, .cyan], startPoint: .bottom, endPoint: .top)
                    .opacity(0.7)
                    .ignoresSafeArea()
                
            }
            
            ScrollView{
                photoView
                inputsView
            }
            if !vm.email.isEmpty {
                signOutButton
            }
        }
    }
}

extension ProfileView {
    private var photoView: some View {
        VStack{
            Text("My profile".capitalized)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
            Spacer()
            ZStack {
                
                if let profileImage = vm.profileImage {
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 92, height: 92)
                        .clipShape(Circle())
                        .padding(4)
                        .background(.white)
                        .cornerRadius(.infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: .infinity)
                                .stroke(.cyan,
                                        lineWidth: 4))
                }
                else {
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFill()
                        .padding()
                        .frame(width: 92, height: 92)
                        .background(.white)
                        .cornerRadius(.infinity)
                        .clipped()
                        .overlay(
                            RoundedRectangle(cornerRadius: .infinity)
                                .stroke(.cyan,
                                        lineWidth: 4))
                    
                        .foregroundColor(.gray)
                }
                
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .frame(width: 14, height: 14)
                    .padding(6)
                    .scaledToFit()
                    .background(.cyan)
                    .cornerRadius(.infinity)
                    .clipped()
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.leading, 58)
                    .padding(.bottom, 77)
            }
            .onTapGesture {
                imagePickerPresented.toggle()
            }
            .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage) {
                ImagePicker(image: $vm.selectedProfileImage)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 160)
    }
    
    private var inputsView: some View {
        VStack{
            GeometryReader { geo in
                Wave(waveHeight: 7, phase: Angle(degrees: Double(geo.frame(in: .global).minY) * 0.58))
                    .foregroundColor(.white.opacity(0.29))
                    .frame(height: 29)
                    .padding(.top, -11)
            }
            VStack{
                TextFieldSingleLineView(bindText: $vm.name, placeHolderText: "name", imageSystemName: "person")
                    .keyboardType(.namePhonePad)
                TextFieldSingleLineView(bindText:  $vm.surname, placeHolderText: "surname", imageSystemName: "person.bust")
                    .keyboardType(.namePhonePad)
                TextFieldSingleLineView(bindText:  $vm.email, placeHolderText: "email", imageSystemName: "envelope")
                    .keyboardType(.namePhonePad)
                TextFieldSingleLineView(bindText:  $vm.phone, placeHolderText: "phone", imageSystemName: "phone")
                    .disabled(true)
                
                Spacer()
                    .frame(minHeight: 29)
                
                Button(action: {
                    vm.saveUserProfile(email: vm.email, name: vm.name, surname: vm.surname)
                }) {
                    Text("Save")
                        .font(.headline)
                }
                .frame(width: 229)
                .foregroundColor(Color(.white))
                .padding()
                .background(.green)
                .cornerRadius(4)
                
                .onReceive(vm.$isUserProfileSaved) { isSaved in
                    guard let isSaved = isSaved else {return}
                    withAnimation(.spring()){
                        isUserProfileSaved = isSaved
                    }
                }
                
            }
            .padding(.vertical)
            .background(.white.opacity(0.29))
        }
        .padding(.top)
    }
    
    private var signOutButton : some View {
        VStack{
            Button {
                presentLogoutAlert.toggle()
            } label: {
                Text("Sign Out")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .alert("Sign Out?", isPresented: $presentLogoutAlert, actions: {
            Button("Sign Out", role: .destructive, action: {
                vm.signOut()
            })
        }, message: {
            Text("You will be logged out of your account.")
        })
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
    
    func loadImage(){
        guard let selectedProfileImage = vm.selectedProfileImage else{return}
        vm.profileImage = Image(uiImage: selectedProfileImage)
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(isUserProfileSaved: .constant(false))
    }
}
