//
//  ProfileView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 4.11.2022.
//

import SwiftUI
struct ProfileView: View {
    @StateObject private var vm = ProfileViewModel()
    
    @State private var selectedProfileImage: UIImage?
    @State var profileImage: Image?
    @State var imagePickerPresented = false
    
    private let gridItem = GridItem(.flexible(), spacing: 14)
    var body: some View {
        ZStack(alignment: .top){
            LinearGradient(colors: [.green, .cyan], startPoint: .bottom, endPoint: .top)
                .opacity(0.7)
                .ignoresSafeArea()
            
            // Photo View
            ScrollView{
                photoView
                inputsView
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
                
                if let profileImage = profileImage {
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
                ImagePicker(image: $selectedProfileImage)
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
                TextFieldSingleLineView(bindText:  $vm.surname, placeHolderText: "surname", imageSystemName: "person.bust")
                TextFieldSingleLineView(bindText:  $vm.email, placeHolderText: "email", imageSystemName: "envelope")
                TextFieldSingleLineView(bindText:  $vm.phone, placeHolderText: "phone", imageSystemName: "phone")
                    .disabled(true)
            }
            .padding(.vertical)
            .background(.white.opacity(0.29))
        }
        .padding(.top)
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
        guard let selectedProfileImage = selectedProfileImage else{return}
        profileImage = Image(uiImage: selectedProfileImage)
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
