//
//  ContentView.swift
//  Shared
//
//  Created by Jonathan Huber on 5/12/22.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) private var recipes: FetchedResults<Recipe>
    @FetchRequest(sortDescriptors: []) private var items: FetchedResults<Item>
    
    var body: some View {
        TabView {
            RecipesView(recipes: recipes)
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Recipes")
                }
            
            ShoppingListView(items: items)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Shopping List")
                }
        }
    }
}
