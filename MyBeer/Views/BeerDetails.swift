//
//  DetailsView.swift
//  MyBeer
//
//  Created by Victor Brigido on 14/02/24.
//

import SwiftUI


struct BeerDetails: View {
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    let beer: Beer
    var isFavorite: Bool {favoritesViewModel.isFavorite(beer)}
    
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
    
    
    
    var body: some View {
     
        ZStack {
                
                Rectangle() // Simula a barra de navegação
                    .foregroundColor(Color.blue1)
                    .frame(height: 120)
                    .edgesIgnoringSafeArea([.top])
                
                
                HStack {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("Beer Details")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        if self.isFavorite {
                            self.favoritesViewModel.removeFromFavorites(self.beer)
                        } else {
                            self.favoritesViewModel.addToFavorites(self.beer)
                        }
                    }) {
                        Image(systemName: self.isFavorite ? "star.fill" : "star")
                            .foregroundColor(self.isFavorite ? .yellow : .white1)
                            .font(.title)
                            .imageScale(.small)
                    }
                    
                    
                }
                .padding(.bottom, 70)
                .padding(.horizontal)
                
            }

            
        
        
            VStack(alignment: .leading, spacing: 16) {
                
                
                HStack(spacing: 16) {
                    
                    if let image_url = URL(string: beer.image_url!), let imageData = try? Data(contentsOf: image_url), let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                    }
                    
                  
                    Text(beer.name!)
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding()
                
             
                Text(beer.description!)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding()
                
                Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    BeerList()
}
