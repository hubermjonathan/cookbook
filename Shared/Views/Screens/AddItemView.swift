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
    
    private var dataController: DataController = DataController.shared
    
    @State private var name: String = ""
    @State private var category: String = ItemCategory.other.rawValue
    @State private var amount: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
                
                Section(header: Text("Category")) {
                    Picker("Category", selection: $category) {
                        ForEach(ItemCategory.allCases.map { category in category.rawValue }, id: \.self) { category in
                            Text(category)
                        }
                    }
                }
                
                Section(header: Text("Amount")) {
                    TextField("Amount", text: $amount)
                }
            }
            .navigationTitle("Add Item")
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
                        addItem()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                            .bold()
                    }
                    .disabled(isAddItemButtonDisabled())
                }
            }
        }
    }
}

extension AddItemView {
    private func isAddItemButtonDisabled() -> Bool {
        return name.isEmpty || amount.isEmpty
    }
    
    private func addItem() {
        let item = Item(context: moc)
        item.name = name
        item.category = category
        item.amount = amount
        dataController.save()
    }
}
