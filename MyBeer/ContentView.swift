//
//  ContentView.swift
//  MyBeer
//
//  Created by Victor Brigido on 14/02/24.
//

import SwiftUI

struct ContentView: View {
    let favoritesViewModel = FavoritesViewModel()
    var beers: [Beer] = []
    
    var body: some View {
        @State var activeTab: Tab = .beerList
        
        TabView(selection: $activeTab) {
            BeerList()
                .tag(Tab.beerList)
                .tabItem { Tab.beerList.tabContent }
            
            Search()
                .tag(Tab.search)
                .tabItem { Tab.search.tabContent }
            
            Favoritos()
                .tag(Tab.favoritos)
                .tabItem { Tab.favoritos.tabContent }
            
            
        }
        .accentColor(Color.blue2)
        .environmentObject(favoritesViewModel)
    }
  
      
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
