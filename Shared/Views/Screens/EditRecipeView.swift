//
//  EditRecipeView.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/15/22.
//

import SwiftUI

struct EditRecipeView: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.presentationMode) private var presentationMode
    @State var recipe: Recipe
    @State var name: String
    @State var ingredientNames: [String]
    @State var ingredientCategories: [String]
    @State var ingredientAmounts: [String]
    @State var instructionSteps: [String]
    
    private func isEditRecipeButtonDisabled() -> Bool {
        return name.isEmpty || ingredientNames.isEmpty || ingredientNames.contains("") || ingredientCategories.isEmpty || ingredientCategories.contains("") || ingredientAmounts.isEmpty || ingredientAmounts.contains("") || instructionSteps.isEmpty || instructionSteps.contains("")
    }
    
    private func editRecipe() {
        for ingredient in recipe.ingredientsSorted {
            recipe.removeFromIngredients(ingredient)
        }
        
        for instruction in recipe.instructionsSorted {
            recipe.removeFromInstructions(instruction)
        }
        
        recipe.name = name
        
        for index in 0 ..< ingredientNames.count {
            let ingredient = Ingredient(context: moc)
            ingredient.name = ingredientNames[index]
            ingredient.category = ingredientCategories[index]
            ingredient.amount = ingredientAmounts[index]
            recipe.addToIngredients(ingredient)
        }
        
        for index in 0 ..< instructionSteps.count {
            let instruction = Instruction(context: moc)
            instruction.order = Int16(index + 1)
            instruction.step = instructionSteps[index]
            recipe.addToInstructions(instruction)
        }
        
        try? moc.save()
    }
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $name)
            }
            
            IngredientsListEditor(categories: $ingredientCategories, names: $ingredientNames, amounts: $ingredientAmounts)
            
            InstructionsListEditor(steps: $instructionSteps)
            
            Button("Edit Recipe") {
                editRecipe()
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(isEditRecipeButtonDisabled())
        }
        .navigationTitle("Edit Recipe")
    }
}
