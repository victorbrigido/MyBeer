//
//  Sobre.swift
//  MyBeer
//
//  Created by Victor Brigido on 15/02/24.
//

import SwiftUI
import Combine

struct Search: View {
    /// View Properties
    @State private var searchText = ""
    @State private var searchResults: [Beer] = []
    let searchPublisher = PassthroughSubject<String, Never>() // Editor de publicação para enviar o texto de pesquisa
    
    @State private var beers: [Beer] = []
    
    
    var body: some View {
        NavigationView {
            
            HStack {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        if searchResults.isEmpty && !searchText.isEmpty {
                            // Exibe imagem e texto "Nenhum resultado encontrado" se a pesquisa não retornar nada
                         
                            VStack {
                                Image("image1")
                                    .font(.system(size: 150))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("Nenhum resultado encontrado para '\(searchText)'.")
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                            .padding(.top, 150)
                        } else {
                            // lista de resultados de pesquisa
                            ForEach(searchResults.isEmpty ? [] : searchResults) { beer in
                                NavigationLink(destination: BeerDetails(beer: beer)) {
                                    BeerCard(beer: beer)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                .padding()
           
            }
            .overlay(content: {
                ContentUnavailableView("Search Beers", systemImage: "magnifyingglass")
                    .opacity(searchResults.isEmpty && searchText.isEmpty ? 1 : 0)
            })
            .onChange(of: searchText) { newValue in
                // Atualiza a lista de resultados de pesquisa
                updateSearchResults()
                print(searchText)
            }
            .onReceive(searchPublisher.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main), perform: { text in
                searchText = text
            })
            .searchable(text: $searchText) // Habilita a busca
            .navigationBarTitle("Search Beers")
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                                   
                    }) {
                        Image(systemName: "camera")
                                .foregroundColor(.blue2)
                    }
                    
        
                    Button(action: {
                                   
                    }) {
                        Image(systemName: "ellipsis.circle.fill")
                            .foregroundColor(.blue2)
                       
                                }
                
                            }
                        )
            .onAppear {
                fetchBeers { fetchedBeers in
                    if let fetchedBeers = fetchedBeers {
                        self.beers = fetchedBeers
                    }
                }
            }
            
        }
        .background(Color.blue1)
    }
    
    private func updateSearchResults() {
        // Limpa os resultados da pesquisa anteriores
        searchResults.removeAll()
        
        // Verifica se há algum texto de pesquisa
        guard !searchText.isEmpty else {
            // Se o texto de pesquisa estiver vazio, não há necessidade de realizar uma busca
            return
        }
        
        // Realiza a busca filtrando as cervejas com base no texto de pesquisa
        searchResults = beers.filter { beer in
            return beer.name!.lowercased().contains(searchText.lowercased())
        }
    }
}

#Preview {
    ContentView()
}



