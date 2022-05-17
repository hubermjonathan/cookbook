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
    
    private var dataController: DataController = DataController.shared
    
    @State private var name: String = ""
    @State private var image: UIImage = UIImage(named: "Placeholder.png")!
    @State private var isShowingImagePicker: Bool = false
    @State private var category: String = RecipeCategory.other.rawValue
    @State private var ingredientNames: [String] = []
    @State private var ingredientCategories: [String] = []
    @State private var ingredientAmounts: [String] = []
    @State private var instructionSteps: [String] = []
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name and Image")) {
                    HStack {
                        Button(action: {
                            isShowingImagePicker = true
                        }) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .cornerRadius(10)
                                .padding([.vertical, .trailing], 10)
                        }
                        .buttonStyle(.borderless)
                        
                        TextField("Name", text: $name)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Section(header: Text("Category")) {
                    Picker("Category", selection: $category) {
                        ForEach(RecipeCategory.allCases.map { category in category.rawValue }, id: \.self) { category in
                            Text(category)
                        }
                    }
                }
                
                IngredientsListEditor(names: $ingredientNames, categories: $ingredientCategories, amounts: $ingredientAmounts)
                
                InstructionsListEditor(steps: $instructionSteps)
            }
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: $image)
            }
            .navigationTitle("Add Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addRecipe()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                            .bold()
                    }
                    .disabled(isAddRecipeButtonDisabled())
                }
            }
        }
    }
}

extension AddRecipeView {
    private func isAddRecipeButtonDisabled() -> Bool {
        return name.isEmpty || ingredientNames.isEmpty || ingredientNames.contains("") || ingredientCategories.isEmpty || ingredientCategories.contains("") || ingredientAmounts.isEmpty || ingredientAmounts.contains("") || instructionSteps.isEmpty || instructionSteps.contains("")
    }
    
    private func addRecipe() {
        let recipe = Recipe(context: moc)
        recipe.name = name
        recipe.image = image.pngData()
        recipe.category = category
        
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
