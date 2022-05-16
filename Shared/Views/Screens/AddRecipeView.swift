//
//  AddRecipeView.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/14/22.
//

import SwiftUI

struct AddRecipeView: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.presentationMode) private var presentationMode
    @State private var name: String = ""
    @State private var ingredientNames: [String] = []
    @State private var ingredientCategories: [String] = []
    @State private var ingredientAmounts: [String] = []
    @State private var instructionSteps: [String] = []
    
    private func isAddRecipeButtonDisabled() -> Bool {
        return name.isEmpty || ingredientNames.isEmpty || ingredientNames.contains("") || ingredientCategories.isEmpty || ingredientCategories.contains("") || ingredientAmounts.isEmpty || ingredientAmounts.contains("") || instructionSteps.isEmpty || instructionSteps.contains("")
    }
    
    private func addRecipe() {
        let recipe = Recipe(context: moc)
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
            
            Button("Add Recipe") {
                addRecipe()
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(isAddRecipeButtonDisabled())
        }
        .navigationTitle("Add Recipe")
    }
}
