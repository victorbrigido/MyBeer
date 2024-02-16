//
//  BeerList.swift
//  MyBeer
//
//  Created by Victor Brigido on 14/02/24.
//

import SwiftUI

struct BeerList: View {
    @State private var beers: [Beer] = []
    @State private var selectedBeer: Beer? = nil
    
    
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
                    ForEach(beers) { beer in
                        NavigationLink(destination: BeerDetails(beer: beer), tag: beer, selection: $selectedBeer) {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            selectedBeer = beer
                        }) {
                            BeerCard(beer: beer)
                        }
                        .padding(.vertical, -25)
                        .padding()
                    }
                }
            }
            .padding(.top, 15)
            .navigationBarItems(trailing:
                    HStack() {
           
                        Text("Beer List")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
         
                            }
                        .frame(width: 360, alignment: .center)
                        )
                        .background(Color.blue1)
                        .onAppear {
                            fetchBeers { fetchedBeers in
                                if let fetchedBeers = fetchedBeers {
                                    self.beers = fetchedBeers
                                }
                            }
                        }
                    }
        
                }
            }



struct BeerList_Previews: PreviewProvider {
    static var previews: some View {
        BeerList()
    }
}
