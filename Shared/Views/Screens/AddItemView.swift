//
//  AddItemView.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/13/22.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.presentationMode) private var presentationMode
    @State private var name: String = ""
    @State private var category: Category = Category.other
    @State private var amount: String = ""
    
    private func isAddItemButtonDisabled() -> Bool {
        return name.isEmpty || amount.isEmpty
    }
    
    private func addItem() {
        let item = Item(context: moc)
        item.name = name
        item.category = category.rawValue
        item.amount = amount
        try? moc.save()
    }
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $name)
            }
            
            Section(header: Text("Category")) {
                Picker("Category of item", selection: $category) {
                    ForEach(Category.allCases, id: \.self) { category in
                        Text(category.rawValue)
                    }
                }
            }
            
            Section(header: Text("Amount")) {
                TextField("Number of item", text: $amount)
            }
            
            Button("Add Item") {
                addItem()
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(isAddItemButtonDisabled())
        }
        .navigationTitle("Add Item")
    }
}
