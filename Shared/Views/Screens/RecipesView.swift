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
                ForEach(RecipeCategory.allCases, id: \.self) { category in
                    Section(header: Text(category.rawValue)) {
                        ForEach(recipes.filter { recipe in recipe.category ?? RecipeCategory.other.rawValue == category.rawValue }) { recipe in
                            NavigationLink(destination: RecipeDetailsView(recipe: recipe)) {
                                RecipeRow(recipe: recipe)
                            }
                        }
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
