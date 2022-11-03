//
//  CountrySelectionView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 1.11.2022.
//

import SwiftUI

struct CountrySelectionView: View {
#if os(macOS)
    @Environment(\.presentationMode) var presentationMode
#endif
    @StateObject private var vm = CountrySelectionViewModel()
    @State private var selectedCountryCode: String?
    @Binding var selectedCountry : CountriesQuery.Data.Country
  
    var body: some View {
        VStack{
#if os(macOS)
            HStack{
                Text("Choose your country code")
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                }
                .padding(.horizontal,14)
                .padding(.vertical,4)
                .buttonStyle(.borderless)
                .background(.cyan)
                .cornerRadius(4)
                .foregroundColor(.white)
                
            }
            .padding(.horizontal)
            .padding()
#endif
            SearchBarView(searchText: $vm.searchText)
#if os(macOS)
                .padding(.top, 0)
#else
                .padding(.top, 29)
#endif
            Spacer()
                .frame(height: 29)
            selectedCountryView
            Divider()
                .padding(.vertical, 7)
            
            List(vm.countries, id: \.code, selection: $selectedCountryCode) { country in
                
                CountrySelectionCellView(country: country, selectedCountry: $vm.selectedCountry)
                    .tag(country.code)
            }
            .listStyle(.plain)
            .onAppear{
                selectedCountryCode = vm.selectedCountry.code
            }
            .onChange(of: selectedCountryCode ?? vm.selectedCountry.code) { tagCountryCode in
                vm.selectCountyCode(selectedCountryCode: tagCountryCode)
                selectedCountry = vm.selectedCountry
            }
        }
        
        
    }
}

extension CountrySelectionView {
    private var selectedCountryView: some View {
        HStack{
            Text(vm.selectedCountry.emoji)
            Text(vm.selectedCountry.name)
            Spacer()
            Text("+\(vm.selectedCountry.phone)")
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.cyan)
                .font(.system(size: 20, weight: .bold, design: .default))
        }
        .fontWeight(.bold)
        .foregroundColor(Color(.darkGray))
        .frame(height: 50)
        .padding(.horizontal)
    }
}

struct CountrySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let selectedCountry = CountriesQuery.Data.Country(code: "DE", name: "Germany", emoji: "🇩🇪", phone: "49")
        CountrySelectionView(selectedCountry: .constant(selectedCountry))
    }
}
