//
//  HomeView.swift
//  AdminSwiftUI_Mac
//
//  Created by Baris OZGEN on 26.10.2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var columnVisibility =
    NavigationSplitViewVisibility.doubleColumn
    
    var body: some View {
        sideBarMenu
    }
}

extension HomeView {
    
    private var sideBarMenu: some View {
        NavigationSplitView(columnVisibility: $columnVisibility){
           SideMenuView()
        }
    content: {
        SideMenuView()
            .navigationTitle("Menu")
    }
        detail: {
            EditProductView()
        }
        /*
         it is for < macOS 13.0
         
        .toolbar{
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSideBar) {
                    Image(systemName: "sidebar.left")
                }
            }
        }*/
    }
    /*
     it is for < macOS 13.0
    func toggleSideBar (){
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
     */
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
