//
//  CountrySelectionView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 1.11.2022.
//

import SwiftUI

struct CountrySelectionView: View {
    @StateObject private var vm = CountrySelectionViewModel()
    var body: some View {
        VStack{
            SearchBarView(searchText: $vm.searchText)
                .padding(.top)
            Spacer()
                .frame(height: 38)
            List(vm.countries, id: \.code) { country in
                
                CountrySelectionCellView(country: country, selectedCode: $vm.selectedCountry.code)
                
            }
            .listStyle(.plain)
        }
        
    }
}

struct CountrySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CountrySelectionView()
    }
}
