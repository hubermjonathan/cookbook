//
//  RecipesView.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/13/22.
//

import SwiftUI

struct RecipesView: View {
    var recipes: FetchedResults<Recipe>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeDetailsView(recipe: recipe)) {
                        Text(recipe.name!)
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationBarTitle("Recipes")
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: AddRecipeView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
