//
//  FavoritesViewModel.swift
//  MyBeer
//
//  Created by Victor Brigido on 15/02/24.
//


import Foundation
import SwiftUI




class FavoritesViewModel: ObservableObject {
    @Published var favoriteBeers: [Beer] = [] {
        didSet {
            saveFavorites()
        }
    }
    
    // Property to store cached images
    var imageCache = NSCache<NSString, UIImage>()
    
    init() {
        loadFavorites()
    }
    
    func addToFavorites(_ beer: Beer) {
        if !isFavorite(beer) {
            favoriteBeers.append(beer)
        }
    }
    
    func removeFromFavorites(_ beer: Beer) {
        if let index = favoriteBeers.firstIndex(where: { $0.id == beer.id }) {
            favoriteBeers.remove(at: index)
        }
    }
    
    func isFavorite(_ beer: Beer) -> Bool {
        favoriteBeers.contains { $0.id == beer.id }
    }
    
    private func saveFavorites() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favoriteBeers) {
            UserDefaults.standard.set(encoded, forKey: "favoriteBeers")
        }
    }
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: "favoriteBeers") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Beer].self, from: data) {
                favoriteBeers = decoded
            }
        }
    }
}



//class FavoritesViewModel: ObservableObject {
//    @Published var favoriteBeers: [Beer] = [] {
//        didSet {
//            saveFavorites()
//        }
//    }
//
//    init() {
//        loadFavorites()
//    }
//
//    func addToFavorites(_ beer: Beer) {
//        if !isFavorite(beer) {
//            favoriteBeers.append(beer)
//        }
//    }
//
//    func removeFromFavorites(_ beer: Beer) {
//        if let index = favoriteBeers.firstIndex(where: { $0.id == beer.id }) {
//            favoriteBeers.remove(at: index)
//        }
//    }
//
//    func isFavorite(_ beer: Beer) -> Bool {
//        favoriteBeers.contains { $0.id == beer.id }
//    }
//
//    private func saveFavorites() {
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(favoriteBeers) {
//            UserDefaults.standard.set(encoded, forKey: "favoriteBeers")
//        }
//    }
//
//    private func loadFavorites() {
//        if let data = UserDefaults.standard.data(forKey: "favoriteBeers") {
//            let decoder = JSONDecoder()
//            if let decoded = try? decoder.decode([Beer].self, from: data) {
//                favoriteBeers = decoded
//            }
//        }
//    }
//}
