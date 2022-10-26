//
//  SideMenuView.swift
//  AdminSwiftUI_Mac
//
//  Created by Baris OZGEN on 26.10.2022.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        List(SideBarMenu.allCases) { menu in
            HStack{
                Image(systemName: menu.image)
                Text(menu.title)
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("Menu")
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
