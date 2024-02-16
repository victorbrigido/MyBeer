//
//  Beer.swift
//  MyBeer
//
//  Created by Victor Brigido on 14/02/24.
//

import Foundation
import UIKit

struct Beer: Identifiable, Hashable {
    let id: Int?
    let name: String?
    let tagline: String?
    let first_brewed: String?
    let description: String?
    let image_url: String?
    let abv: Double?
    let ibu: Double?
    
    // cached image
    var cachedImage: UIImage?
    
    enum CodingKeys: String, CodingKey {
            case id
            case name
            case tagline
            case first_brewed
            case description
            case image_url
            case abv
            case ibu
        }
}

extension Beer: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        first_brewed = try container.decodeIfPresent(String.self, forKey: .first_brewed)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        image_url = try container.decodeIfPresent(String.self, forKey: .image_url)
        abv = try container.decodeIfPresent(Double.self, forKey: .abv)
        ibu = try container.decodeIfPresent(Double.self, forKey: .ibu)
        cachedImage = nil // Inicializar a imagem em cache como nil
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(tagline, forKey: .tagline)
        try container.encode(first_brewed, forKey: .first_brewed)
        try container.encode(description, forKey: .description)
        try container.encode(image_url, forKey: .image_url)
        try container.encode(abv, forKey: .abv)
        try container.encode(ibu, forKey: .ibu)
    }
}

func fetchBeers(completion: @escaping ([Beer]?) -> Void) {
    guard let url = URL(string: "https://api.punkapi.com/v2/beers") else {
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            completion(nil)
            return
        }
        
        do {
            var beers = try JSONDecoder().decode([Beer].self, from: data)
            
            // Download and cache images
            for index in beers.indices {
                if let urlString = beers[index].image_url, let url = URL(string: urlString) {
                    if let cachedImage = FavoritesViewModel().imageCache.object(forKey: urlString as NSString) {
                        beers[index].cachedImage = cachedImage
                    } else {
                        if let imageData = try? Data(contentsOf: url) {
                            if let image = UIImage(data: imageData) {
                                beers[index].cachedImage = image
                                FavoritesViewModel().imageCache.setObject(image, forKey: urlString as NSString)
                            }
                        }
                    }
                }
            }
            
            completion(beers)
        } catch {
            print("Error decoding JSON: \(error)")
            completion(nil)
        }
    }.resume()
}






//struct Beer: Codable, Identifiable, Hashable {
//    let id: Int?
//    let name: String?
//    let tagline: String?
//    let first_brewed: String?
//    let description: String?
//    let image_url: String?
//    let abv: Double?
//    let ibu: Double?
//}
//
//
//
//func fetchBeers(completion: @escaping ([Beer]?) -> Void) {
//    guard let url = URL(string: "https://api.punkapi.com/v2/beers") else {
//        completion(nil)
//        return
//    }
//
//    URLSession.shared.dataTask(with: url) { data, response, error in
//        guard let data = data, error == nil else {
//            completion(nil)
//            return
//        }
//
//        do {
//            let beers = try JSONDecoder().decode([Beer].self, from: data)
//            completion(beers)
//        } catch {
//            print("Error decoding JSON: \(error)")
//            completion(nil)
//        }
//    }.resume()
//}
