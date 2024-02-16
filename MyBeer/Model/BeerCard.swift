//
//  BeerCard.swift
//  MyBeer
//
//  Created by Victor Brigido on 14/02/24.
//

import SwiftUI

struct BeerCard: View {
    let beer: Beer
    
    var body: some View {
        HStack(spacing: 16) {
            // Adiciona a imagem do lado esquerdo
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
            
            // Adiciona o nome e a tagline à direita da imagem
            VStack(alignment: .leading, spacing: 8) {
                Text(beer.name!)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(beer.tagline!)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.trailing, 8)
            
            Spacer()
        }
        .padding()
        .background(Color.white1)
        .cornerRadius(10)
    }
}

#Preview {
   BeerList()
}
