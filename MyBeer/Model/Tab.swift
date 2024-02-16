//
//  Tab.swift
//  MyBeer
//
//  Created by Victor Brigido on 15/02/24.
//

import Foundation
import SwiftUI

enum Tab: String {
    case beerList = "List"
    case favoritos = "Favorites"
    case search = "Search"
    
    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .beerList:
            Image(systemName: "list.bullet")
            Text(self.rawValue)
        case .favoritos:
            Image(systemName: "star")
            Text(self.rawValue)
        case .search:
            Image(systemName: "magnifyingglass")
            Text(self.rawValue)
        }
    }
}

