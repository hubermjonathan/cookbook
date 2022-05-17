//
//  EditItem.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/16/22.
//

import SwiftUI

struct EditItemView: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.presentationMode) private var presentationMode
    
    private var dataController: DataController = DataController.shared
    
    @State private var name: String
    @State private var category: String
    @State private var amount: String
    
    @ObservedObject var item: Item
    
    init(item: Item) {
        self.item = item
        _name = State(initialValue: item.name ?? Constants.UNKOWN_NAME)
        _category = State(initialValue: item.category ?? Constants.UNKOWN_CATEGORY)
        _amount = State(initialValue: item.amount ?? Constants.UNKOWN_AMOUNT)
    }
    
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
            .navigationTitle("Edit Item")
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
                        editItem()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                            .bold()
                    }
                    .disabled(isEditItemButtonDisabled())
                }
            }
        }
    }
}

extension EditItemView {
    private func isEditItemButtonDisabled() -> Bool {
        return name.isEmpty || amount.isEmpty
    }
    
    private func editItem() {
        item.name = name
        item.category = category
        item.amount = amount
        dataController.save()
    }
}
