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
    
    @State private var isShowingEditRecipe: Bool = false
    @State private var isShowingConfirmRemove: Bool = false
    
    @ObservedObject var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(uiImage: getRecipeImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .padding(.trailing, 10)
                
                Text(recipe.name ?? Constants.UNKOWN_NAME)
                    .font(.title)
                    .bold()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            
            List {
                Section(header: Text("Ingredients")) {
                    ForEach(recipe.ingredientsWrapper) { ingredient in
                        HStack {
                            Text(ingredient.name ?? Constants.UNKOWN_NAME)
                            
                            Spacer()
                            
                            Text(ingredient.amount ?? Constants.UNKOWN_AMOUNT)
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
                            
                            Text(instruction.step ?? Constants.UNKOWN_STEP)
                        }
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationBarTitle(Text(""), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingEditRecipe = true
                    }) {
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
            .sheet(isPresented: $isShowingEditRecipe) {
                EditRecipeView(recipe: recipe)
            }
        }
    }
}

extension RecipeDetailsView {
    private func getRecipeImage() -> UIImage {
        if recipe.image == nil {
            return UIImage(named: "Placeholder.png")!
        } else {
            return UIImage(data: recipe.image!) ?? UIImage(named: "Placeholder.png")!
        }
    }
    
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
