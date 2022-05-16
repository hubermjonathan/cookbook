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
    
    private var dataController: DataController = DataController.shared
    
    @State var name: String = ""
    @State var ingredientNames: [String] = []
    @State var ingredientCategories: [String] = []
    @State var ingredientAmounts: [String] = []
    @State var instructionSteps: [String] = []
    
    @ObservedObject var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.name = recipe.name!
        self.ingredientNames = recipe.ingredientsWrapper.map { ingredient in ingredient.name! }
        self.ingredientCategories = recipe.ingredientsWrapper.map { ingredient in ingredient.category! }
        self.ingredientAmounts = recipe.ingredientsWrapper.map { ingredient in ingredient.amount! }
        self.instructionSteps = recipe.instructionsWrapper.map { instruction in instruction.step! }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $name)
            }
            
            IngredientsListEditor(names: $ingredientNames, categories: $ingredientCategories, amounts: $ingredientAmounts)
            
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

extension EditRecipeView {
    private func isEditRecipeButtonDisabled() -> Bool {
        return name.isEmpty || ingredientNames.isEmpty || ingredientNames.contains("") || ingredientCategories.isEmpty || ingredientCategories.contains("") || ingredientAmounts.isEmpty || ingredientAmounts.contains("") || instructionSteps.isEmpty || instructionSteps.contains("")
    }
    
    private func editRecipe() {
        for ingredient in recipe.ingredientsWrapper {
            recipe.removeFromIngredients(ingredient)
        }
        
        for instruction in recipe.instructionsWrapper {
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
        
        dataController.save()
    }
}
