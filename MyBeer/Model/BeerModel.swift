//
//  Beer.swift
//  MyBeer
//
//  Created by Victor Brigido on 14/02/24.
//

import Foundation


struct Beer: Identifiable {
    let id: String
    let name: String
    let description: String
}



var beerList = [
    Beer(id: "1", name: "IPA", description: "India Pale Ale is a hoppy beer style within the broader category of pale ale."),
    Beer(id: "2", name: "Stout", description: "Stout is a dark, top-fermented beer with a number of variations, including dry stout, oatmeal stout, milk stout, and imperial stout."),
    Beer(id: "3", name: "Pilsner", description: "Pilsner is a type of pale lager. It takes its name from the Bohemian city of Plzeň, where it was first produced in 1842."),
    Beer(id: "4", name: "Wheat Beer", description: "Wheat beer is a beer, usually top-fermented, which is brewed with a large proportion of wheat relative to the amount of malted barley."),
    Beer(id: "5", name: "Saison", description: "Saison is a pale ale that is highly carbonated, fruity, spicy, and often bottle conditioned."),
    Beer(id: "6", name: "Porter", description: "Porter is a dark style of beer developed in London from well-hopped beers made from brown malt.")
]
