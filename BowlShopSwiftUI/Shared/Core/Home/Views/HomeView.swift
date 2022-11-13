//
//  HomeView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 12.11.2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = HomeViewModel()
    
    @State private var searchText = ""
    @State private var filterViewVisibility = false
    @State private var filterCalories = 429.0
    @State private var filterCaloriesEditing = false

    let columns = [
            GridItem(.adaptive(minimum: 180))
        ]
    
    var body: some View {
        ZStack {
            productListView
            headerView
            footerView
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color(.systemGray6))
    }
}

extension HomeView {
    
    private var headerView: some View {
        ZStack{
            GeometryReader { geo in
                Wave(waveHeight: 7, phase: Angle(degrees: Double(geo.frame(in: .global).minY) * 7.29))
                    .foregroundColor(.white)
            }
            .scaleEffect(y: -1)
            .frame(height: 129)
            .edgesIgnoringSafeArea(.top)
            HStack{
                Image(systemName: "line.3.horizontal.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                Spacer()
                Image("bowloshop-logo-baris")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 29)
                Spacer()
                Image(systemName: "cart.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
            }
            .foregroundColor(Color(.systemGreen))
            .padding()
      
        }
        .padding(.vertical)
        .frame(maxHeight: .infinity,alignment: .top)
    }
    private var footerView: some View {
        ZStack{
            HStack{
                Image(systemName: "slider.vertical.3")
                    .resizable()
                    .scaledToFit()
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .frame(width: 20)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(.white)
                            .shadow(
                                color: .black.opacity(0.29),
                                radius: 7,x: 0, y: 7
                            )
                    )
                    .onTapGesture {
                        filterViewVisibility.toggle()
                    }
                    .sheet(isPresented: $filterViewVisibility){
                        filterView
                            .accessibilityIdentifier("cardViewPageBottom")
                            .presentationDetents([.height(292), .fraction(0.4)])
                            .presentationDragIndicator(.visible)
                    }
                Spacer()
                SearchBarView(searchText: $searchText)
            }
            .padding()
        }
        .padding(.vertical)
        .frame(maxHeight: .infinity,alignment: .bottom)
    }
    
    private var filterView: some View {
        VStack(alignment: .leading){
            Text("Filters")
                .font(.headline)
            Divider()
                .padding(.vertical)
            Text("Calories < \(Int(filterCalories))")
                .foregroundColor(.gray)
            HStack{
                Slider(
                        value: $filterCalories,
                        in: 0...700,
                        step: 10
                    ) {
                        Text("Calorie")
                    } minimumValueLabel: {
                        Text("100")
                    } maximumValueLabel: {
                        Text("700")
                    }
              
            }
            Divider()
                .padding(.vertical)
            Text("Ingredients")
                .foregroundColor(.gray)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(FoodIngredient.allCases, id: \.id){ ingredient in
                        HStack{
                            Toggle(isOn: .constant(true), label: {
                                HStack{
                                    Image(systemName: ingredient.image)
                                    Text(ingredient.title.capitalized)
                                }
                            })
                           
                            .foregroundColor(.gray)
                        }
                        .padding(.all, 4)
                        .background(.white.opacity(0.92))
                        .cornerRadius(4)
                    }
                }
                    
                }
            .frame(height: 35)
        }
        .padding()
    }
    
    private var productListView: some View {
        ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(vm.products, id: \.id ) { product in
                            ProductCellView(product: product)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(maxHeight: 1000)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
