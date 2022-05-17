//
//  IngredientsListEditor.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/15/22.
//

import SwiftUI

struct IngredientsListEditor: View {
    @Binding var names: [String]
    @Binding var categories: [String]
    @Binding var amounts: [String]
    
    private func getNamesBinding(forIndex index: Int) -> Binding<String> {
        return Binding<String>(
            get: { names[index] },
            set: { name in names[index] = name }
        )
    }
    
    private func getCategoryBinding(forIndex index: Int) -> Binding<String> {
        return Binding<String>(
            get: { categories[index] },
            set: { category in categories[index] = category }
        )
    }
    
    private func getAmountsBinding(forIndex index: Int) -> Binding<String> {
        return Binding<String>(
            get: { amounts[index] },
            set: { amount in amounts[index] = amount }
        )
    }
    
    var body: some View {
        Section(header: Text("Ingredients")) {
            ForEach(0 ..< names.count, id: \.self) { index in
                ListItem(name: getNamesBinding(forIndex: index), category: getCategoryBinding(forIndex: index), amount: getAmountsBinding(forIndex: index)) {
                    self.categories.remove(at: index)
                    self.names.remove(at: index)
                    self.amounts.remove(at: index)
                }
            }
            
            AddButton() {
                self.categories.append(Category.other.rawValue)
                self.names.append("")
                self.amounts.append("")
            }
        }
    }
}

fileprivate struct ListItem: View {
    @Binding var name: String
    @Binding var category: String
    @Binding var amount: String
    
    var removeAction: () -> Void
    
    var body: some View {
        VStack {
            Picker("Category", selection: $category) {
                ForEach(Category.allCases.map { category in category.rawValue }, id: \.self) { category in
                    Text(category)
                }
            }
            .padding(.vertical, 5)
            
            // TODO: fix tap area for picker
            
            HStack {
                TextField("Name", text: $name)
                
                Divider()
                
                TextField("Amount", text: $amount)
            }
            .padding(.vertical, 5)
        }
        .swipeActions(edge: .trailing) {
            Button(action: {
                removeAction()
                let hapticFeedback = UINotificationFeedbackGenerator()
                hapticFeedback.notificationOccurred(.success)
            }) {
                Image(systemName: "trash.fill")
            }
            .tint(.red)
        }
    }
}

fileprivate struct AddButton: View {
    var addAction: () -> Void
    
    var body: some View {
        Button(action: addAction) {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.green)
                    .padding(.horizontal)
                
                Text("add ingredient")
            }
        }
    }
}
