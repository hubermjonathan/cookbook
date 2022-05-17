//
//  RecipesView.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/13/22.
//

import SwiftUI

struct RecipesView: View {
    @State private var isShowingAddRecipe: Bool = false
    
    var recipes: FetchedResults<Recipe>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeDetailsView(recipe: recipe)) {
                        RecipeRow(recipe: recipe)
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationBarTitle("Recipes")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        isShowingAddRecipe = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .popover(isPresented: $isShowingAddRecipe) {
                AddRecipeView()
            }
        }
    }
}
