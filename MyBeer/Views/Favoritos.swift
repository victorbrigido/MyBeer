//
//  Favoritos.swift
//  MyBeer
//
//  Created by Victor Brigido on 15/02/24.
//

import SwiftUI

struct Favoritos: View {
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    init() {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.blue1
            // Aplica o UINavigationBarAppearance globalmente
            UINavigationBar.appearance().standardAppearance = appearance
        }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(favoritesViewModel.favoriteBeers) { beer in
                        NavigationLink(destination: BeerDetails(beer: beer)) {
                            BeerCard(beer: beer)
                        }
                        .buttonStyle(PlainButtonStyle()) // Para remover o estilo padrão do NavigationLink
                        .padding()
                        .padding(.vertical, -15)
                    }
                }
            }
            .padding(.top, 15)
//            .navigationBarTitle("Favoritos")
            .navigationBarItems(trailing:
                HStack {
                    Text("Favorites")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal, 70)
                    }
                .frame(width: 360, alignment: .center)
            )
            .background(Color.blue1)
        }
    }
}



import SwiftUI

struct Favoritos_Previews: PreviewProvider {
    static var previews: some View {
        let favoritesViewModel = FavoritesViewModel()
        return Favoritos().environmentObject(favoritesViewModel)
    }
}

