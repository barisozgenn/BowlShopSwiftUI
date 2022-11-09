//
//  RootView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 8.11.2022.
//

import SwiftUI

struct RootView: View {
    @StateObject private var vm = RootViewModel()
    @State private var animRotate: Double = -14
    @State private var animIsOver = false
    var body: some View {
        
        ZStack{
            
            if animIsOver {
                if let _ = vm.userSession
                {
#if os(macOS)
                    HomeView()
#else
                    ProductDetailView()
#endif
                }
                else {
                    LoginView()
                }
            }
            
            if !vm.viewIsLoaded {
                launchView
                    .onReceive(vm.$animIsOver) { isOver in
                        withAnimation(.easeOut(duration: 1)){
                            animIsOver = isOver
                        }
                    }
            }
        }
        
        
    }
}

extension RootView {
    
    private var launchView: some View {
        ZStack{
                GeometryReader { geo in
                    
                    VStack{
                        Spacer()
                        Wave(waveHeight: 14 , phase: Angle(degrees: Double(geo.frame(in: .global).minY) * 0.7))
                            .foregroundColor(.black.opacity(0.14))
                            .frame( height: 170)
                    }
                  
                }
            
            
            VStack{
                Spacer()
                Image("bowloshop-logo-white-baris")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128)
                    .rotationEffect(Angle(degrees: animRotate))
                    .onAppear{
                        withAnimation(.easeOut(duration: 1.29).repeatForever()){
                            animRotate = 29
                        }
                    }
                Spacer()
                Text("BowlShop")
                    .font(.system(size: 58))
                Text("SwiftUI Multi Platform")
                    .font(.title2)
            }
            .padding(.vertical, 29)
            .foregroundColor(.white)
            .fontWeight(.bold)
            
            
        }
        .background(content: {
            LinearGradient(colors: [.cyan, .green], startPoint: .top, endPoint: .bottom)
                .opacity(0.7)
        })
        .scaleEffect(animIsOver ? 4 : 1)
        .opacity(animIsOver ? 0 : 1)
        .ignoresSafeArea()
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
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
