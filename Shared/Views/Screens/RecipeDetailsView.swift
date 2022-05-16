//
//  RecipeDetailsView.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/14/22.
//

import SwiftUI

struct RecipeDetailsView: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.presentationMode) private var presentationMode
    
    private var dataController: DataController = DataController.shared
    
    @State private var isShowingConfirmRemove: Bool = false
    
    @ObservedObject var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        List {
            Section(header: Text("Ingredients")) {
                ForEach(recipe.ingredientsWrapper) { ingredient in
                    HStack {
                        Text(ingredient.name!)
                        
                        Spacer()
                        
                        Text(ingredient.amount!)
                            .padding(.trailing, 5)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(action: {
                            addItemToShoppingList(ingredient: ingredient)
                            let hapticFeedback = UINotificationFeedbackGenerator()
                            hapticFeedback.notificationOccurred(.success)
                        }) {
                            Image(systemName: "plus")
                        }
                        .tint(.green)
                    }
                }
            }
            
            Section(header: Text("Instructions")) {
                ForEach(recipe.instructionsWrapper) { instruction in
                    HStack {
                        Text("\(instruction.order).")
                            .padding(.trailing, 5)
                        
                        Text(instruction.step!)
                    }
                }
            }
        }
        .listStyle(.sidebar)
        .navigationBarTitle(recipe.name!)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: EditRecipeView(recipe: recipe)) {
                    Image(systemName: "pencil")
                        .padding(.trailing, 5)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isShowingConfirmRemove = true
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
                .confirmationDialog("Are you sure you want to remove this recipe?", isPresented: $isShowingConfirmRemove) {
                    Button("Remove", role: .destructive) {
                        removeRecipe()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .padding(.trailing, 5)
            }
        }
    }
}

extension RecipeDetailsView {
    private func removeRecipe() {
        dataController.delete(recipe)
    }
    
    private func addItemToShoppingList(ingredient: Ingredient) {
        let item = Item(context: moc)
        item.name = ingredient.name
        item.category = ingredient.category
        item.amount = ingredient.amount
        dataController.save()
    }
}
