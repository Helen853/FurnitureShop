//
//  TabView.swift
//  FurnitureShop

import SwiftUI

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}

struct Tab: View {
    
    private enum Constants {
        static let gooddsItem = "Icon"
        static let filtersItem = "bag"
        static let profileItem = "smiley"
    }
    
    init() {
       UITabBar.appearance().unselectedItemTintColor = .secondaryLabel
    }
    
    var body: some View {
        TabView {
            GoodsView()
                .tabItem {
                    Image(Constants.gooddsItem)
                        .renderingMode(.template)
                        .foregroundColor(Color(.secondaryLabel))
                }
            
            FiltersView()
                .tabItem {
                    Image(Constants.filtersItem)
                        .renderingMode(.template)
                        .foregroundColor(Color(.secondaryLabel))
                }
            
            UserPrifileView()
                .tabItem {
                    Image(systemName: Constants.profileItem)
                        .renderingMode(.template)
                        .foregroundColor(Color(.secondaryLabel))
                }
            
        }.accentColor(.green)
            .navigationBarBackButtonHidden(true)
    }
}






