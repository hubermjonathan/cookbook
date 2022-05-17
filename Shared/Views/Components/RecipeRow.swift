//
//  RecipeRow.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/16/22.
//

import SwiftUI

struct RecipeRow: View {
    @ObservedObject var recipe: Recipe
    
    var body: some View {
        HStack {
            Image(uiImage: getRecipeImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75)
                .cornerRadius(10)
                .padding(.trailing, 10)
            
            Text(recipe.name ?? Constants.UNKOWN_NAME)
        }
    }
}

extension RecipeRow {
    private func getRecipeImage() -> UIImage {
        if recipe.image == nil {
            return UIImage(named: "Placeholder.png")!
        } else {
            return UIImage(data: recipe.image!) ?? UIImage(named: "Placeholder.png")!
        }
    }
}
